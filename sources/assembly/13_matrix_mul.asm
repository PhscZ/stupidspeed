; task 13 matrix_mul — expected output: 599995000
; build: nasm -f elf64 13_matrix_mul.asm && ld -o prog 13_matrix_mul.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.
; n = 500, plain i,j,k triple loop in that order, no reordering, no library.

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
    mov r9, rbx
    imul r9, 500
    add r9, rcx                 ; i*n + j
    mov rax, rbx
    add rax, rcx                ; i + j
    xor rdx, rdx
    mov r8, 7
    div r8
    mov [r14+r9*8], rdx         ; A[i][j] = (i+j) mod 7
    inc rcx
    cmp rcx, 500
    jb .jA
    inc rbx
    cmp rbx, 500
    jb .fillA

    xor rbx, rbx
.fillB:
    xor rcx, rcx
.jB:
    mov r9, rbx
    imul r9, 500
    add r9, rcx
    mov rax, rbx
    imul rax, rcx               ; i * j
    xor rdx, rdx
    mov r8, 5
    div r8
    mov [r15+r9*8], rdx         ; B[i][j] = (i*j) mod 5
    inc rcx
    cmp rcx, 500
    jb .jB
    inc rbx
    cmp rbx, 500
    jb .fillB

    xor rbx, rbx                ; i
.ik:
    xor rcx, rcx                ; j
.jk:
    xor r12, r12                ; sum = 0
    xor r8, r8                  ; k
.kk:
    mov rax, rbx
    imul rax, 500
    add rax, r8                 ; i*n + k
    mov rdx, [r14+rax*8]        ; A[i][k]
    mov rax, r8
    imul rax, 500
    add rax, rcx                ; k*n + j
    imul rdx, [r15+rax*8]       ; A[i][k] * B[k][j]
    add r12, rdx
    inc r8
    cmp r8, 500
    jb .kk
    mov r9, rbx
    imul r9, 500
    add r9, rcx
    mov [r13+r9*8], r12         ; C[i][j] = sum
    inc rcx
    cmp rcx, 500
    jb .jk
    inc rbx
    cmp rbx, 500
    jb .ik

    xor r12, r12                ; sum of all C values
    xor rcx, rcx
.sum:
    add r12, [r13+rcx*8]
    inc rcx
    cmp rcx, 250000
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
A:      resq 250000
B:      resq 250000
C:      resq 250000
numbuf:  resb 32
charbuf: resb 1

section .note.GNU-stack noalloc noexec nowrite progbits
