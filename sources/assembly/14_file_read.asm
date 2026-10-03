; task 14 file_read — expected output: 2389704704
; build: nasm -f win64 14_file_read.asm -o 14_file_read.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 14_file_read.obj kernel32.lib
; run: prog.exe    (from this directory, with data.bin beside it)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.
; Reads data.bin from the working directory in 1 MiB chunks with CreateFileA/ReadFile
; and prints the byte total modulo 4294967296.

default rel
global main

extern GetStdHandle
extern WriteFile
extern ExitProcess
extern CreateFileA
extern ReadFile
extern CloseHandle

section .text
main:
    and rsp, -16
    sub rsp, 64
    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [stdout], rax

    ; h = CreateFileA("data.bin", GENERIC_READ, FILE_SHARE_READ, NULL,
    ;                 OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
    lea rcx, [fname]
    mov edx, 0x80000000         ; GENERIC_READ
    mov r8d, 1                  ; FILE_SHARE_READ
    xor r9d, r9d                ; lpSecurityAttributes = NULL
    mov qword [rsp+32], 3       ; OPEN_EXISTING
    mov qword [rsp+40], 0x80    ; FILE_ATTRIBUTE_NORMAL
    mov qword [rsp+48], 0       ; hTemplateFile = NULL
    call CreateFileA
    mov r12, rax                ; hFile

    xor r13, r13                ; total
    lea r14, [chunk]            ; 1 MiB buffer

.read:
    mov rcx, r12
    mov rdx, r14
    mov r8d, 1048576
    lea r9, [bytesread]
    mov qword [rsp+32], 0       ; lpOverlapped = NULL
    call ReadFile
    mov eax, [bytesread]
    test eax, eax
    jz .done                    ; end of file

    xor rcx, rcx
.sum:
    movzx edx, byte [r14+rcx]
    add r13, rdx                ; total += b
    inc rcx
    cmp rcx, rax
    jb .sum
    jmp .read

.done:
    mov rcx, r12
    call CloseHandle

    mov eax, r13d               ; total mod 4294967296
    mov rdi, rax
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
fname: db 'data.bin', 0

section .bss
chunk:     resb 1048576
bytesread: resd 1
numbuf:    resb 32
charbuf:   resb 1
written:   resd 1
stdout:    resq 1
