; task 12 matrix_add — expected output: 999000000
;
; MASM x64 (ml64.exe) for Windows, no CRT and no printf: the only imports are
; kernel32.dll's GetStdHandle, WriteFile, HeapCreate, HeapAlloc and ExitProcess.
; Three 8 MB int64 arrays, 1000 by 1000, built and walked in row-major order.
;
; build:
;   ML="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/ml64.exe"
;   LINK="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe"
;   export LIB='C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64'
;   "$ML" /nologo /c /Fo prog.obj 12_matrix_add.asm
;   "$LINK" /nologo /subsystem:console /entry:main /out:prog.exe prog.obj kernel32.lib
; run: C:/stupidspeed/sources/masm/prog.exe   (absolute path: this shell does not resolve ./prog.exe)

OPTION CASEMAP:NONE

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN HeapCreate:PROC
EXTERN HeapAlloc:PROC
EXTERN ExitProcess:PROC
INCLUDELIB kernel32.lib

PUBLIC main

N      EQU 1000
ELEMS  EQU N*N
NBYTES EQU ELEMS*8

.data
written DQ 0
charbuf DB 0

.data?
outhandle DQ ?
numbuf DB 32 DUP(?)
heap DQ ?

.code

main PROC
    push rbp
    mov rbp, rsp
    sub rsp, 64
    and rsp, -16                ; the entry stack is only 8-byte aligned

    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [outhandle], rax

    xor ecx, ecx                ; HeapCreate(0, 0, 0)
    xor edx, edx
    xor r8d, r8d
    call HeapCreate
    mov [heap], rax

    mov rcx, [heap]             ; A
    xor edx, edx
    mov r8, NBYTES
    call HeapAlloc
    mov rdi, rax
    mov rcx, [heap]             ; B
    xor edx, edx
    mov r8, NBYTES
    call HeapAlloc
    mov rsi, rax
    mov rcx, [heap]             ; C
    xor edx, edx
    mov r8, NBYTES
    call HeapAlloc
    mov rbx, rax

    xor r8, r8                  ; i
Lfill_i:
    xor r9, r9                  ; j
Lfill_j:
    mov rax, r8
    imul rax, rax, N
    add rax, r9                 ; i * n + j
    mov rdx, r8
    add rdx, r9
    mov [rdi+rax*8], rdx        ; A[i][j] = i + j
    mov rdx, r8
    sub rdx, r9
    mov [rsi+rax*8], rdx        ; B[i][j] = i - j
    inc r9
    cmp r9, N
    jb Lfill_j
    inc r8
    cmp r8, N
    jb Lfill_i

    xor r8, r8
Ladd_i:
    xor r9, r9
Ladd_j:
    mov rax, r8
    imul rax, rax, N
    add rax, r9
    mov rdx, [rdi+rax*8]
    add rdx, [rsi+rax*8]
    mov [rbx+rax*8], rdx        ; C[i][j] = A[i][j] + B[i][j]
    inc r9
    cmp r9, N
    jb Ladd_j
    inc r8
    cmp r8, N
    jb Ladd_i

    xor rax, rax                ; total
    xor rcx, rcx
    mov rdx, ELEMS
Lsum:
    add rax, [rbx+rcx*8]
    inc rcx
    cmp rcx, rdx
    jb Lsum

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
