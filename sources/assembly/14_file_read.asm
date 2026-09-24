; task 14 file_read — expected output: 484442112
; build: nasm -f elf64 14_file_read.asm && ld -o prog 14_file_read.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.
; Reads data.bin from the working directory in 1 MiB chunks and prints the
; byte total modulo 4294967296.

default rel
global _start

section .text
_start:
    mov eax, 2                  ; open
    lea rdi, [fname]
    xor esi, esi                ; O_RDONLY
    xor edx, edx                ; mode
    syscall
    mov r12, rax                ; fd

    xor r13, r13                ; total
    lea r14, [chunk]            ; 1 MiB buffer

.read:
    xor eax, eax                ; read
    mov rdi, r12
    mov rsi, r14
    mov rdx, 1048576
    syscall
    test rax, rax
    jle .done                   ; end of file

    xor rcx, rcx
.sum:
    movzx edx, byte [r14+rcx]
    add r13, rdx                ; total += b
    inc rcx
    cmp rcx, rax
    jb .sum
    jmp .read

.done:
    mov eax, 3                  ; close
    mov rdi, r12
    syscall

    mov eax, r13d               ; total mod 4294967296
    mov rdi, rax
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
fname: db 'data.bin', 0

section .bss
chunk:  resb 1048576
numbuf:  resb 32
charbuf: resb 1

section .note.GNU-stack noalloc noexec nowrite progbits
