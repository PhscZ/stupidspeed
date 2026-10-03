; task 06 char_count — expected output: 10000000
; build: nasm -f win64 06_char_count.asm -o 06_char_count.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 06_char_count.obj kernel32.lib
; run: prog.exe    (from this directory)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.
; The 100000000 character text lives in .bss and is built once, before the scan.

default rel
global main

extern GetStdHandle
extern WriteFile
extern ExitProcess

section .text
main:
    and rsp, -16
    sub rsp, 48
    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [stdout], rax

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

    xor ecx, ecx                ; exit
    call ExitProcess

; ---------------------------------------------------------------------------
; print the unsigned 64-bit value in rdi as decimal
print_u64:
    sub rsp, 40
    lea rsi, [numbuf+32]
    mov rax, rdi
    mov r10, 10
.digit:
    xor rdx, rdx
    div r10
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz .digit
    mov rcx, [stdout]
    mov rdx, rsi
    lea r8, [numbuf+32]
    sub r8, rsi
    lea r9, [written]
    mov qword [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret

; ---------------------------------------------------------------------------
; write the single byte in dil
putc:
    sub rsp, 40
    mov [charbuf], dil
    mov rcx, [stdout]
    lea rdx, [charbuf]
    mov r8d, 1
    lea r9, [written]
    mov qword [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret

section .rodata
pattern: db 'abcdefghij'

section .bss
text:   resb 100000000
numbuf:  resb 32
charbuf: resb 1
written: resd 1
stdout:  resq 1
