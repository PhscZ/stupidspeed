; task 15 file_write — expected output: 52428800
; build: nasm -f win64 15_file_write.asm -o 15_file_write.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 15_file_write.obj kernel32.lib
; run: prog.exe    (from this directory)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.
; Writes the 1 MiB pattern buffer 50 times to out.bin with CreateFileA/WriteFile,
; closes it, then prints the number of bytes written. kernel32 has no fsync on a
; file handle, so this row flushes by closing, the same deviation Tcl, D, Julia,
; Nim, Dart, Pascal and others note.

default rel
global main

extern GetStdHandle
extern WriteFile
extern ExitProcess
extern CreateFileA
extern CloseHandle

section .text
main:
    and rsp, -16
    sub rsp, 64
    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [stdout], rax

    ; h = CreateFileA("out.bin", GENERIC_WRITE, 0, NULL,
    ;                 CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL)
    lea rcx, [fname]
    mov edx, 0x40000000         ; GENERIC_WRITE
    xor r8d, r8d                ; dwShareMode = 0
    xor r9d, r9d                ; lpSecurityAttributes = NULL
    mov qword [rsp+32], 2       ; CREATE_ALWAYS
    mov qword [rsp+40], 0x80    ; FILE_ATTRIBUTE_NORMAL
    mov qword [rsp+48], 0       ; hTemplateFile = NULL
    call CreateFileA
    mov r12, rax                ; hFile

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
    mov rbx, 50
.loop:
    mov rcx, r12
    mov rdx, r14
    mov r8d, 1048576
    lea r9, [written]
    mov qword [rsp+32], 0       ; lpOverlapped = NULL
    call WriteFile
    mov eax, [written]
    add r13, rax
    dec rbx
    jnz .loop

    mov rcx, r12
    call CloseHandle

    mov rdi, r13
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
fname: db 'out.bin', 0

section .bss
chunk:   resb 1048576
numbuf:  resb 32
charbuf: resb 1
written: resd 1
stdout:  resq 1
