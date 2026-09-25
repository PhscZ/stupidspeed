; task 11 parallel_sum — expected output: 7500000075000000
; build: nasm -f elf64 11_parallel_sum.asm && ld -o prog 11_parallel_sum.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.
; The four workers are real kernel threads, made with the raw clone(2) syscall and joined
; with futex(2). That is the same two syscalls pthread_create/pthread_join issue underneath,
; written out by hand because there is no libc here to do it for us.
; The work is task 02's switch split into four fixed 25000000-iteration ranges, so the four
; threads together do exactly the work of task 02 and print the same number.

default rel
global _start

; clone(2) flags: what pthread_create passes, minus the TLS setup this program does not use.
CLONE_VM        equ 0x00000100
CLONE_FS        equ 0x00000200
CLONE_FILES     equ 0x00000400
CLONE_SIGHAND   equ 0x00000800
CLONE_THREAD    equ 0x00010000
CLONE_SYSVSEM   equ 0x00040000
CLONE_FLAGS     equ CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM

FUTEX_WAIT      equ 0
FUTEX_WAKE      equ 1

SYS_clone       equ 56
SYS_futex       equ 202
SYS_exit        equ 60

NTHREADS        equ 4
CHUNK           equ 25000000
STACK_SHIFT     equ 16                      ; 65536 bytes of stack per worker

section .text
_start:
    xor r12, r12                            ; t

.spawn:
    lea rsi, [stacks]                       ; child stack top = stacks + (t+1) * 65536
    lea rax, [r12+1]
    shl rax, STACK_SHIFT
    add rsi, rax
    and rsi, -16

    mov edi, CLONE_FLAGS
    xor edx, edx                            ; parent_tid
    xor r10d, r10d                          ; child_tid
    xor r8d, r8d                            ; tls
    mov eax, SYS_clone
    syscall

    test rax, rax
    jz worker                               ; rax == 0 means this is the new thread

    inc r12
    cmp r12, NTHREADS
    jb .spawn

; the main thread owns no range: it waits until all four workers have stored their partial
; sums and counted themselves out
.join:
    mov eax, [done]
    cmp eax, NTHREADS
    je .sum
    lea rdi, [done]
    mov esi, FUTEX_WAIT
    mov edx, eax                            ; expected value; EAGAIN if it changed
    xor r10d, r10d                          ; no timeout
    mov eax, SYS_futex
    syscall
    jmp .join

.sum:
    xor r13, r13
    xor ecx, ecx
.sloop:
    add r13, [partials + rcx*8]
    inc ecx
    cmp ecx, NTHREADS
    jb .sloop

    mov rdi, r13
    call print_u64
    mov edi, 10
    call putc

    mov eax, SYS_exit
    xor edi, edi
    syscall

; ---------------------------------------------------------------------------
; one worker: r12 = t, running on its own stack. The switch is a real jump table over i & 3.
worker:
    imul r14, r12, CHUNK                    ; first i of this range
    lea r15, [r14+CHUNK]                    ; one past the last i
    xor r13, r13                            ; acc

w_loop:
    mov rax, r14
    and eax, 3                              ; i mod 4
    lea rcx, [jtab]
    mov edx, dword [rcx+rax*4]
    add rdx, rcx
    jmp rdx

; the switch table: 32-bit self-relative offsets to the four cases
jtab:
    dd w_case0 - jtab
    dd w_case1 - jtab
    dd w_case2 - jtab
    dd w_case3 - jtab

w_case0:
    inc r13                                 ; acc += 1
    jmp w_next
w_case1:
    add r13, r14                            ; acc += i
    jmp w_next
w_case2:
    lea rdx, [r14+r14]                      ; 2*i
    add r13, rdx
    jmp w_next
w_case3:
    lea rdx, [r14+r14*2]                    ; 3*i
    add r13, rdx

w_next:
    inc r14
    cmp r14, r15
    jb w_loop

    lea rax, [partials]
    mov [rax + r12*8], r13                  ; publish this range's partial sum

    mov eax, 1                              ; count the worker that just finished
    lock xadd dword [done], eax
    inc eax
    cmp eax, NTHREADS
    jne w_leave
    lea rdi, [done]                         ; last one out wakes the main thread
    mov esi, FUTEX_WAKE
    mov edx, NTHREADS
    mov eax, SYS_futex
    syscall

w_leave:
    mov eax, SYS_exit                       ; exit(2) in a CLONE_THREAD child ends this
    xor edi, edi                            ; thread only; the process stays alive
    syscall

; ---------------------------------------------------------------------------
; print the unsigned 64-bit value in rdi as decimal
print_u64:
    lea rsi, [numbuf+31]
    mov rax, rdi
    mov rcx, 10
.digit:
    xor rdx, rdx
    div rcx
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz .digit
    lea rdx, [numbuf+32]
    sub rdx, rsi
    mov eax, 1                              ; write
    mov edi, 1                              ; stdout
    syscall
    ret

; ---------------------------------------------------------------------------
; write the single byte in dil
putc:
    mov [charbuf], dil
    mov eax, 1
    mov edi, 1
    lea rsi, [charbuf]
    mov edx, 1
    syscall
    ret

section .bss
align 8
partials: resq NTHREADS
done:     resd 1
alignb 16
stacks:   resb 262144                       ; NTHREADS * 65536
numbuf:   resb 32
charbuf:  resb 1

section .note.GNU-stack noalloc noexec nowrite progbits
