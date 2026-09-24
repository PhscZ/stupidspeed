; task 08 average — expected output: 0.498046875
; build: nasm -f elf64 main.asm && ld -o prog main.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.
; The mean is printed as an exact decimal: the fraction is scaled by 1e9 and
; printed with nine digits, so no floating point formatting is needed.

default rel
global _start

section .text
_start:
    xorpd xmm0, xmm0            ; total = 0.0
    movsd xmm2, [c256]          ; 256.0
    xor r12, r12                ; i

.loop:
    mov eax, r12d
    and eax, 255                ; i mod 256
    cvtsi2sd xmm1, eax
    divsd xmm1, xmm2            ; reading = (i mod 256) / 256.0
    addsd xmm0, xmm1            ; total += reading
    inc r12
    cmp r12, 100000000
    jb .loop

    divsd xmm0, [c1e8]          ; total / 100000000
    mulsd xmm0, [c1e9]          ; fraction scaled to an integer
    cvttsd2si rdi, xmm0
    call print_frac9

    mov eax, 60                 ; exit
    xor edi, edi
    syscall

; ---------------------------------------------------------------------------
; print "0." followed by the nine digits of rdi (0 .. 999999999)
print_frac9:
    mov byte [outbuf], '0'
    mov byte [outbuf+1], '.'
    lea rsi, [outbuf+11]
    mov byte [rsi], 10          ; newline
    mov rax, rdi
    mov rcx, 10
    mov r8, 9
.digit:
    xor rdx, rdx
    div rcx
    add dl, '0'
    dec rsi
    mov [rsi], dl
    dec r8
    jnz .digit
    lea rsi, [outbuf]
    mov edx, 12
    mov eax, 1                  ; write
    mov edi, 1                  ; stdout
    syscall
    ret

section .rodata
c256: dq 256.0
c1e8: dq 100000000.0
c1e9: dq 1000000000.0

section .bss
outbuf: resb 16

section .note.GNU-stack noalloc noexec nowrite progbits
