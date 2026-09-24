; task 07 string_append — expected output: 1000000
; build: nasm -f elf64 main.asm && ld -o prog main.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.
; text = text + "x" is emulated the plain way: the whole current string is
; copied into the other buffer, so the append is quadratic, exactly the point.

default rel
global _start

section .text
_start:
    lea r14, [bufA]             ; current text
    lea r15, [bufB]             ; new text
    xor rbx, rbx                ; length of text

.loop:
    mov rsi, r14
    mov rdi, r15
    mov rcx, rbx
    rep movsb                   ; new = copy of the old text
    mov byte [r15+rbx], 'x'     ; new = new + "x"
    inc rbx
    xchg r14, r15               ; the new buffer becomes the current text
    cmp rbx, 1000000
    jb .loop

    mov rdi, rbx                ; length of text
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
bufA:   resb 1000008
bufB:   resb 1000008
numbuf:  resb 32
charbuf: resb 1

section .note.GNU-stack noalloc noexec nowrite progbits
