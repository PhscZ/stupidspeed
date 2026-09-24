; task 05 alloc_churn — expected output: 1274991808
; build: nasm -f elf64 main.asm && ld -o prog main.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.
; Every iteration is a real mmap of 64 bytes plus the munmap of the buffer it
; replaces, so this one is syscall bound by construction.

default rel
global _start

section .text
_start:
    lea rbx, [slots]            ; 256 buffer slots
    xor r12, r12                ; i
    xor r13, r13                ; total

.loop:
    mov eax, 9                  ; mmap
    xor edi, edi                ; addr = NULL
    mov esi, 64                 ; length = 64 bytes
    mov edx, 3                  ; PROT_READ | PROT_WRITE
    mov r10d, 0x22              ; MAP_PRIVATE | MAP_ANONYMOUS
    mov r8, -1                  ; fd = -1
    xor r9d, r9d                ; offset = 0
    syscall
    mov r15, rax                ; fresh 64 byte buffer

    mov rcx, r12
    and ecx, 255                ; i mod 256
    mov edx, r12d
    and edx, 255
    mov [r15], dl               ; buf[0] = i mod 256
    add r13, rdx                ; total += buf[0]

    mov r14, [rbx+rcx*8]        ; the buffer this slot replaces
    test r14, r14
    jz .store
    mov rdi, r14                ; munmap(old, 64)
    mov esi, 64
    mov eax, 11
    syscall

.store:
    mov rcx, r12
    and ecx, 255
    mov [rbx+rcx*8], r15        ; slots[i mod 256] = buf

    inc r12
    cmp r12, 10000000
    jb .loop

    mov rdi, r13
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
slots:  resq 256
numbuf:  resb 32
charbuf: resb 1

section .note.GNU-stack noalloc noexec nowrite progbits
