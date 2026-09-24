; task 06 char_count — expected output: 10000000
; build: nasm -f elf64 06_char_count.asm && ld -o prog 06_char_count.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.
; The 100000000 character text lives in .bss and is built once, before the scan.

default rel
global _start

section .text
_start:
    lea r14, [text]             ; base of the 100 MB text

    ; text = "abcdefghij" repeated 10000000 times, built by doubling
    lea rsi, [pattern]
    mov rdi, r14
    mov ecx, 10
    rep movsb                   ; text[0..10)
    mov rbx, 10                 ; bytes filled so far
.half:
    cmp rbx, 5000000
    jae .half_done
    mov rsi, r14
    lea rdi, [r14+rbx]
    mov rcx, rbx
    rep movsb                   ; double the block
    add rbx, rbx
    jmp .half
.half_done:
    mov rsi, r14
    lea rdi, [r14+rbx]
    mov rcx, 10000000
    sub rcx, rbx
    rep movsb                   ; 10 000 000 bytes, 1 000 000 repetitions
    mov rbx, 10000000
.replicate:
    cmp rbx, 100000000
    jae .scan_start
    mov rsi, r14
    lea rdi, [r14+rbx]
    mov rcx, 10000000
    rep movsb                   ; ten copies fill the whole buffer
    add rbx, 10000000
    jmp .replicate

.scan_start:
    xor r12, r12                ; count of 'h'
    xor rcx, rcx                ; character index
.scan:
    movzx eax, byte [r14+rcx]
    cmp al, 'a'
    je .next
    cmp al, 'e'
    je .next
    cmp al, 'h'
    jne .next
    inc r12
.next:
    inc rcx
    cmp rcx, 100000000
    jb .scan

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

section .rodata
pattern: db 'abcdefghij'

section .bss
text:   resb 100000000
numbuf:  resb 32
charbuf: resb 1

section .note.GNU-stack noalloc noexec nowrite progbits
