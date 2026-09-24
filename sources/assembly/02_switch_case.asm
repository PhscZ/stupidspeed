; task 02 switch_case — expected output: 7500000075000000
; build: nasm -f elf64 02_switch_case.asm && ld -o prog 02_switch_case.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.
; The switch is a real jump table over i & 3, not an if chain.

default rel
global _start

section .text
_start:
    xor r12, r12                ; i
    xor r13, r13                ; acc
    mov r14, 100000000

loop02:
    mov rax, r12
    and eax, 3                  ; i mod 4
    lea rcx, [jtab]
    mov edx, dword [rcx+rax*4]
    add rdx, rcx
    jmp rdx

; the switch table: 32-bit self-relative offsets to the four cases
jtab:
    dd case0 - jtab
    dd case1 - jtab
    dd case2 - jtab
    dd case3 - jtab

case0:
    inc r13                     ; acc += 1
    jmp next02
case1:
    add r13, r12                ; acc += i
    jmp next02
case2:
    lea rdx, [r12+r12]          ; 2*i
    add r13, rdx                ; acc += 2*i
    jmp next02
case3:
    lea rdx, [r12+r12*2]        ; 3*i
    add r13, rdx                ; acc += 3*i

next02:
    inc r12
    cmp r12, r14
    jb loop02

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
numbuf:  resb 32
charbuf: resb 1

section .note.GNU-stack noalloc noexec nowrite progbits
