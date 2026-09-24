; task 03 func_sum — expected output: 100000000
; build: nasm -f elf64 03_func_sum.asm && ld -o prog 03_func_sum.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.
; Assembly never inlines: the call below is a real call, 100000000 times.

default rel
global _start

section .text
_start:
    xor edi, edi                ; value = 0
    mov r12, 100000000

.loop:
    call add_one                ; value = add_one(value)
    dec r12
    jnz .loop

    call print_u64              ; rdi holds value
    mov rdi, 10
    call putc

    mov eax, 60                 ; exit
    xor edi, edi
    syscall

; ---------------------------------------------------------------------------
; add_one(n) = n + 1, argument and result in rdi
add_one:
    lea rdi, [rdi+1]
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
