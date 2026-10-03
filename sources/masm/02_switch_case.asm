; task 02 switch_case — expected output: 7500000075000000
;
; MASM x64 (ml64.exe) for Windows, no CRT and no printf: the only imports are
; kernel32.dll's GetStdHandle, WriteFile and ExitProcess.
; The four-way decision is a real jump table in .data, not a compare chain.
;
; build:
;   ML="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/ml64.exe"
;   LINK="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe"
;   export LIB='C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64'
;   "$ML" /nologo /c /Fo prog.obj 02_switch_case.asm
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
jtab DQ case0, case1, case2, case3

.data?
outhandle DQ ?
numbuf DB 32 DUP(?)

.code

main PROC
    push rbp
    mov rbp, rsp
    sub rsp, 64
    and rsp, -16                ; the entry stack is only 8-byte aligned

    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [outhandle], rax

    xor r8, r8                  ; acc
    xor rbx, rbx                ; i
    mov rsi, 100000000

Lloop:
    mov rax, rbx
    and rax, 3                  ; i % 4
    lea rcx, jtab
    jmp qword ptr [rcx+rax*8]
case0::
    inc r8                      ; acc += 1
    jmp Lnext
case1::
    add r8, rbx                 ; acc += i
    jmp Lnext
case2::
    lea rdx, [rbx+rbx]          ; 2 * i
    add r8, rdx
    jmp Lnext
case3::
    lea rdx, [rbx+rbx*2]        ; 3 * i
    add r8, rdx
Lnext:
    inc rbx
    cmp rbx, rsi
    jb Lloop

    mov rcx, r8
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
