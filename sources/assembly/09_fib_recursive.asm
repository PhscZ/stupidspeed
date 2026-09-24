; task 09 fib_recursive — expected output: 102334155
; build: nasm -f elf64 09_fib_recursive.asm && ld -o prog 09_fib_recursive.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.

default rel
global _start

section .text
_start:
    mov rdi, 40
    call fib
    mov rdi, rax
    call print_u64
    mov rdi, 10
    call putc

    mov eax, 60                 ; exit
    xor edi, edi
    syscall

; ---------------------------------------------------------------------------
; fib(n) = n if n < 2 else fib(n-1) + fib(n-2), naive, no memoization
fib:
    cmp rdi, 2
    jb .base
    push rbx
    push rbp
    mov rbx, rdi
    lea rdi, [rbx-1]
    call fib                    ; fib(n-1)
    mov rbp, rax
    lea rdi, [rbx-2]
    call fib                    ; fib(n-2)
    add rax, rbp
    pop rbp
    pop rbx
    ret
.base:
    mov rax, rdi
    ret

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
