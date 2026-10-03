; task 14 file_read — expected output: 2389704704
;
; MASM x64 (ml64.exe) for Windows, no CRT and no printf: the only imports are
; kernel32.dll's GetStdHandle, WriteFile, ReadFile, CreateFileA, VirtualAlloc,
; CloseHandle and ExitProcess.
; data.bin is read in 1 MiB chunks and every byte is added up; the total is
; printed modulo 4294967296.
;
; build:
;   ML="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/ml64.exe"
;   LINK="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe"
;   export LIB='C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64'
;   "$ML" /nologo /c /Fo prog.obj 14_file_read.asm
;   "$LINK" /nologo /subsystem:console /entry:main /out:prog.exe prog.obj kernel32.lib
; run: C:/stupidspeed/sources/masm/prog.exe   (absolute path: this shell does not resolve
;       ./prog.exe; run it with a 50 MiB data.bin, bytes 0..255 repeating, in the
;       current directory)

OPTION CASEMAP:NONE

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ReadFile:PROC
EXTERN CreateFileA:PROC
EXTERN VirtualAlloc:PROC
EXTERN CloseHandle:PROC
EXTERN ExitProcess:PROC
INCLUDELIB kernel32.lib

PUBLIC main

CHUNK EQU 1048576               ; 1 MiB

.data
written DQ 0
charbuf DB 0
fname DB "data.bin", 0

.data?
outhandle DQ ?
numbuf DB 32 DUP(?)
nread DQ ?

.code

main PROC
    push rbp
    mov rbp, rsp
    sub rsp, 64
    and rsp, -16                ; the entry stack is only 8-byte aligned

    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [outhandle], rax

    lea rcx, fname              ; CreateFileA("data.bin", GENERIC_READ, FILE_SHARE_READ,
    mov edx, 080000000h         ;              NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
    mov r8d, 1
    xor r9d, r9d
    mov qword ptr [rsp+32], 3
    mov qword ptr [rsp+40], 080h
    mov qword ptr [rsp+48], 0
    call CreateFileA
    cmp rax, -1
    je Lfail
    mov rbx, rax                ; file handle

    xor ecx, ecx                ; VirtualAlloc(NULL, CHUNK, MEM_COMMIT|MEM_RESERVE, PAGE_READWRITE)
    mov edx, CHUNK
    mov r8d, 03000h
    mov r9d, 04h
    call VirtualAlloc
    mov rdi, rax                ; buffer

    xor r12, r12                ; total

Lread:
    mov rcx, rbx                ; ReadFile(handle, buf, CHUNK, &nread, NULL)
    mov rdx, rdi
    mov r8d, CHUNK
    lea r9, nread
    mov qword ptr [rsp+32], 0
    call ReadFile
    test eax, eax
    jz Ldone
    mov ecx, dword ptr [nread]
    test ecx, ecx
    jz Ldone

    xor rax, rax
    xor rdx, rdx
Lsumb:
    movzx r10, byte ptr [rdi+rdx]
    add rax, r10
    inc rdx
    cmp rdx, rcx
    jb Lsumb
    add r12, rax
    jmp Lread

Ldone:
    mov rcx, rbx
    call CloseHandle

    mov rcx, r12
    mov rax, 0FFFFFFFFh         ; total mod 4294967296
    and rcx, rax
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
