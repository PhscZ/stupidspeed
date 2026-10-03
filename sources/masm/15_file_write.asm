; task 15 file_write — expected output: 52428800
;
; MASM x64 (ml64.exe) for Windows, no CRT and no printf: the only imports are
; kernel32.dll's GetStdHandle, WriteFile, CreateFileA, VirtualAlloc, CloseHandle
; and ExitProcess.
; A 1 MiB buffer of the bytes 0..255 repeated is written to out.bin fifty times,
; one WriteFile per megabyte. The allowed kernel32 import set has no
; FlushFileBuffers, so the flush is the handle close, the flush-and-close route
; the rows without an fsync already record.
;
; build:
;   ML="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/ml64.exe"
;   LINK="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe"
;   export LIB='C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64'
;   "$ML" /nologo /c /Fo prog.obj 15_file_write.asm
;   "$LINK" /nologo /subsystem:console /entry:main /out:prog.exe prog.obj kernel32.lib
; run: C:/stupidspeed/sources/masm/prog.exe   (absolute path: this shell does not resolve
;       ./prog.exe; writes out.bin, 50 MiB, in the current directory)

OPTION CASEMAP:NONE

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN CreateFileA:PROC
EXTERN VirtualAlloc:PROC
EXTERN CloseHandle:PROC
EXTERN ExitProcess:PROC
INCLUDELIB kernel32.lib

PUBLIC main

CHUNK   EQU 1048576             ; 1 MiB
REPEATS EQU 50

.data
written DQ 0
charbuf DB 0
fname DB "out.bin", 0

.data?
outhandle DQ ?
numbuf DB 32 DUP(?)
nwrote DQ ?

.code

main PROC
    push rbp
    mov rbp, rsp
    sub rsp, 64
    and rsp, -16                ; the entry stack is only 8-byte aligned

    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [outhandle], rax

    xor ecx, ecx                ; VirtualAlloc(NULL, CHUNK, MEM_COMMIT|MEM_RESERVE, PAGE_READWRITE)
    mov edx, CHUNK
    mov r8d, 03000h
    mov r9d, 04h
    call VirtualAlloc
    mov rdi, rax                ; buffer

    xor rcx, rcx
Lfill:
    mov rax, rcx
    and rax, 255                ; byte i % 256
    mov byte ptr [rdi+rcx], al
    inc rcx
    cmp rcx, CHUNK
    jb Lfill

    lea rcx, fname              ; CreateFileA("out.bin", GENERIC_WRITE, 0, NULL,
    mov edx, 040000000h         ;              CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL)
    xor r8d, r8d
    xor r9d, r9d
    mov qword ptr [rsp+32], 2
    mov qword ptr [rsp+40], 080h
    mov qword ptr [rsp+48], 0
    call CreateFileA
    cmp rax, -1
    je Lfail
    mov rbx, rax                ; file handle

    xor r12, r12                ; bytes written
    mov r13, REPEATS
Lwrite:
    mov rcx, rbx                ; WriteFile(handle, buf, CHUNK, &nwrote, NULL)
    mov rdx, rdi
    mov r8d, CHUNK
    lea r9, nwrote
    mov qword ptr [rsp+32], 0
    call WriteFile
    test eax, eax
    jz Lclose
    mov eax, dword ptr [nwrote]
    add r12, rax
    dec r13
    jnz Lwrite

Lclose:
    mov rcx, rbx
    call CloseHandle            ; flushes what is still buffered

    mov rcx, r12
    call print_u64
    mov rcx, 10
    call putc

    xor ecx, ecx
    call ExitProcess

Lfail:
    mov ecx, 1
    call ExitProcess
main ENDP

; ---------------------------------------------------------------------------
; print the unsigned 64-bit value in rcx as decimal
print_u64 PROC
    sub rsp, 40
    mov rax, rcx
    lea r11, numbuf+31
    mov r9, 10
Ldigit:
    xor rdx, rdx
    div r9
    add dl, '0'
    mov byte ptr [r11], dl
    dec r11
    test rax, rax
    jnz Ldigit
    inc r11
    lea r8, numbuf+32
    sub r8, r11
    mov rdx, r11
    mov rcx, [outhandle]
    lea r9, written
    mov qword ptr [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret
print_u64 ENDP

; ---------------------------------------------------------------------------
; write the single byte in cl
putc PROC
    sub rsp, 40
    mov byte ptr [charbuf], cl
    lea rdx, charbuf
    mov r8, 1
    mov rcx, [outhandle]
    lea r9, written
    mov qword ptr [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret
putc ENDP

END
