; task 01 branches — expected output: 33333334 13333333 7619048 45714285
;
; MASM x64 (ml64.exe) for Windows, no CRT and no printf: the only imports are
; kernel32.dll's GetStdHandle, WriteFile and ExitProcess, and stdout is written
; through WriteFile with a hand-rolled decimal printer.
;
; build:
;   ML="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/ml64.exe"
;   LINK="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe"
;   export LIB='C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64'
;   "$ML" /nologo /c /Fo prog.obj 01_branches.asm
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
vals DQ 4 DUP(?)

.code

; ---------------------------------------------------------------------------
; four counters and one if/else chain over i % 3, i % 5 and i % 7
main PROC
    push rbp
    mov rbp, rsp
    sub rsp, 64
    and rsp, -16                ; the entry stack is only 8-byte aligned

    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [outhandle], rax

    xor r8, r8                  ; a
    xor r9, r9                  ; b
    xor r10, r10                ; c
    xor r11, r11                ; d
    xor rbx, rbx                ; i
    mov rsi, 100000000

Lloop:
    mov rax, rbx
    xor rdx, rdx
    mov rcx, 3
    div rcx
    test rdx, rdx
    jz Lcount_a
    mov rax, rbx
    xor rdx, rdx
    mov rcx, 5
    div rcx
    test rdx, rdx
    jz Lcount_b
    mov rax, rbx
    xor rdx, rdx
    mov rcx, 7
    div rcx
    test rdx, rdx
    jz Lcount_c
    inc r11                     ; else: d += 1
    jmp Lnext
Lcount_a:
    inc r8
    jmp Lnext
Lcount_b:
    inc r9
    jmp Lnext
Lcount_c:
    inc r10
Lnext:
    inc rbx
    cmp rbx, rsi
    jb Lloop

    mov [vals], r8              ; park the counters: the printer clobbers r8-r11
    mov [vals+8], r9
    mov [vals+16], r10
    mov [vals+24], r11

    mov rcx, [vals]
    call print_u64
    mov rcx, ' '
    call putc
    mov rcx, [vals+8]
    call print_u64
    mov rcx, ' '
    call putc
    mov rcx, [vals+16]
    call print_u64
    mov rcx, ' '
    call putc
    mov rcx, [vals+24]
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
    sub r8, r11                 ; r8 = length
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
