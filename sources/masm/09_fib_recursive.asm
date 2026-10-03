; task 09 fib_recursive — expected output: 102334155
;
; MASM x64 (ml64.exe) for Windows, no CRT and no printf: the only imports are
; kernel32.dll's GetStdHandle, WriteFile and ExitProcess.
;
; build:
;   ML="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/ml64.exe"
;   LINK="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe"
;   export LIB='C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64'
;   "$ML" /nologo /c /Fo prog.obj 09_fib_recursive.asm
;   "$LINK" /nologo /subsystem:console /entry:main /out:prog.exe prog.obj kernel32.lib
; run: C:/stupidspeed/sources/masm/prog.exe   (absolute path: this shell does not resolve ./prog.exe)

OPTION CASEMAP:NONE

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC
INCLUDELIB kernel32.lib

PUBLIC main

.data
written DQ 0
charbuf DB 0

.data?
outhandle DQ ?
numbuf DB 32 DUP(?)

.code

; ---------------------------------------------------------------------------
; int64 fib(int64 n): if n < 2 return n; else fib(n-1) + fib(n-2)
fib PROC
    cmp rcx, 2
    jb Lbase
    push rbx
    push rsi
    sub rsp, 40
    mov rbx, rcx
    mov rcx, rbx
    dec rcx
    call fib
    mov rsi, rax
    mov rcx, rbx
    sub rcx, 2
    call fib
    add rax, rsi
    add rsp, 40
    pop rsi
    pop rbx
    ret
Lbase:
    mov rax, rcx
    ret
fib ENDP

; ---------------------------------------------------------------------------
main PROC
    push rbp
    mov rbp, rsp
    sub rsp, 64
    and rsp, -16                ; the entry stack is only 8-byte aligned

    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [outhandle], rax

    mov ecx, 40
    call fib

    mov rcx, rax
    call print_u64
    mov rcx, 10
    call putc

    xor ecx, ecx
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
