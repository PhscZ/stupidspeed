; task 15 file_write — expected output: 104857600
; build: nasm -f elf64 main.asm && ld -o prog main.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.
; Writes the 1 MiB pattern buffer 100 times to out.bin, fsyncs, then prints the
; number of bytes written.

default rel
global _start

section .text
_start:
    mov eax, 2                  ; open
    lea rdi, [fname]
    mov esi, 0x241              ; O_WRONLY | O_CREAT | O_TRUNC
    mov edx, 420                ; mode 0644
    syscall
    mov r12, rax                ; fd

    ; buffer = 0,1,2,...,255 repeated 4096 times, built by doubling
    lea r14, [chunk]
    xor rcx, rcx
.init:
    mov [r14+rcx], cl           ; buf[i] = i
    inc rcx
    cmp rcx, 256
    jb .init
    mov rbx, 256
.double:
    cmp rbx, 1048576
    jae .write
    mov rsi, r14
    lea rdi, [r14+rbx]
    mov rcx, rbx
    rep movsb
    add rbx, rbx
    jmp .double

.write:
    xor r13, r13                ; bytes written
    mov rbx, 100
.loop:
    mov eax, 1                  ; write
    mov rdi, r12
    mov rsi, r14
    mov rdx, 1048576
    syscall
    add r13, rax
    dec rbx
    jnz .loop

    mov eax, 74                 ; fsync
    mov rdi, r12
    syscall
    mov eax, 3                  ; close
    mov rdi, r12
    syscall

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

section .rodata
fname: db 'out.bin', 0

section .bss
chunk:  resb 1048576
numbuf:  resb 32
charbuf: resb 1

section .note.GNU-stack noalloc noexec nowrite progbits
