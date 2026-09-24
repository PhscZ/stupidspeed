; task 01 branches — expected output: 33333334 13333333 7619048 45714285
; build: nasm -f elf64 01_branches.asm && ld -o prog 01_branches.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.

default rel
global _start

section .text
_start:
    xor r8, r8                  ; a
    xor r9, r9                  ; b
    xor r10, r10                ; c
    xor r14, r14                ; d
    xor r12, r12                ; i
    mov r13, 100000000

.loop:
    mov rax, r12
    xor rdx, rdx
    mov rcx, 3
    div rcx
    test rdx, rdx
    jz .count_a
    mov rax, r12
    xor rdx, rdx
    mov rcx, 5
    div rcx
    test rdx, rdx
    jz .count_b
    mov rax, r12
    xor rdx, rdx
    mov rcx, 7
    div rcx
    test rdx, rdx
    jz .count_c
    inc r14                     ; else: d += 1
    jmp .next
.count_a:
    inc r8                      ; divisible by 3
    jmp .next
.count_b:
    inc r9                      ; divisible by 5
    jmp .next
.count_c:
    inc r10                     ; divisible by 7
.next:
    inc r12
    cmp r12, r13
    jb .loop

    mov rdi, r8
    call print_u64
    mov rdi, ' '
    call putc
    mov rdi, r9
    call print_u64
    mov rdi, ' '
    call putc
    mov rdi, r10
    call print_u64
    mov rdi, ' '
    call putc
    mov rdi, r14
    call print_u64
    mov rdi, 10
    call putc

    mov eax, 60                 ; exit
    xor edi, edi
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
    mov eax, 1                  ; write
    mov edi, 1                  ; stdout
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
numbuf:  resb 32
charbuf: resb 1

section .note.GNU-stack noalloc noexec nowrite progbits
