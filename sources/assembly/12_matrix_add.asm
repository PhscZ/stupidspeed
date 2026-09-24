; task 12 matrix_add — expected output: 999000000
; build: nasm -f elf64 12_matrix_add.asm && ld -o prog 12_matrix_add.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.
; n = 1000, flat int64 arrays with index i*n+j.

default rel
global _start

section .text
_start:
    lea r14, [A]
    lea r15, [B]
    lea r13, [C]

    xor rbx, rbx                ; i
.fillA:
    xor rcx, rcx                ; j
.jA:
    mov rax, rbx
    imul rax, 1000
    add rax, rcx                ; i*n + j
    mov rdx, rbx
    add rdx, rcx                ; i + j
    mov [r14+rax*8], rdx
    inc rcx
    cmp rcx, 1000
    jb .jA
    inc rbx
    cmp rbx, 1000
    jb .fillA

    xor rbx, rbx
.fillB:
    xor rcx, rcx
.jB:
    mov rax, rbx
    imul rax, 1000
    add rax, rcx
    mov rdx, rbx
    sub rdx, rcx                ; i - j
    mov [r15+rax*8], rdx
    inc rcx
    cmp rcx, 1000
    jb .jB
    inc rbx
    cmp rbx, 1000
    jb .fillB

    xor rbx, rbx
.addC:
    xor rcx, rcx
.jC:
    mov rax, rbx
    imul rax, 1000
    add rax, rcx
    mov rdx, [r14+rax*8]
    add rdx, [r15+rax*8]
    mov [r13+rax*8], rdx        ; C[i][j] = A[i][j] + B[i][j]
    inc rcx
    cmp rcx, 1000
    jb .jC
    inc rbx
    cmp rbx, 1000
    jb .addC

    xor r12, r12                ; sum of all C values
    xor rcx, rcx
.sum:
    add r12, [r13+rcx*8]
    inc rcx
    cmp rcx, 1000000
    jb .sum

    mov rdi, r12
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
A:      resq 1000000
B:      resq 1000000
C:      resq 1000000
numbuf:  resb 32
charbuf: resb 1

section .note.GNU-stack noalloc noexec nowrite progbits
