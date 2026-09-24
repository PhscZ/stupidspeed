; task 04 array_sum — expected output: 499999500000
; build: nasm -f elf64 main.asm && ld -o prog main.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.

default rel
global _start

section .text
_start:
    lea rbx, [array]            ; base of the array
    xor r12, r12                ; i

.fill:
    mov [rbx+r12*8], r12        ; array[i] = i
    inc r12
    cmp r12, 1000000
    jb .fill

    xor r13, r13                ; total
    xor r12, r12

.sum:
    add r13, [rbx+r12*8]        ; total += array[i]
    inc r12
    cmp r12, 1000000
    jb .sum

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
array:  resq 1000000
numbuf:  resb 32
charbuf: resb 1

section .note.GNU-stack noalloc noexec nowrite progbits
