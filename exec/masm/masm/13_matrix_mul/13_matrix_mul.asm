; task 13 matrix_mul — expected output: 599995000
;
; MASM x64 (ml64.exe) for Windows, no CRT and no printf: the only imports are
; kernel32.dll's GetStdHandle, WriteFile, HeapCreate, HeapAlloc and ExitProcess.
; Three 2 MB int64 arrays, 500 by 500, and the plain i, j, k triple loop in
; that order: 125 million multiply-adds, no blocking and no reordering.
;
; build:
;   ML="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/ml64.exe"
;   LINK="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe"
;   export LIB='C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64'
;   "$ML" /nologo /c /Fo prog.obj 13_matrix_mul.asm
;   "$LINK" /nologo /subsystem:console /entry:main /out:prog.exe prog.obj kernel32.lib
; run: C:/stupidspeed/sources/masm/prog.exe   (absolute path: this shell does not resolve ./prog.exe)

OPTION CASEMAP:NONE

EXTERN GetStdHandle:PROC
EXTERN QueryPerformanceCounter:PROC
EXTERN QueryPerformanceFrequency:PROC
EXTERN WriteFile:PROC
EXTERN HeapCreate:PROC
EXTERN HeapAlloc:PROC
EXTERN ExitProcess:PROC
INCLUDELIB kernel32.lib

PUBLIC main

N      EQU 500
ELEMS  EQU N*N
NBYTES EQU ELEMS*8

.data
written DQ 0
charbuf DB 0
tmsg DB "TIME_MS="

.data?
outhandle DQ ?
qfreq DQ ?
t0 DQ ?
t1 DQ ?
twhole DQ ?
tfrac DQ ?
errhandle DQ ?
tnumbuf DB 40 DUP(?)
numbuf DB 32 DUP(?)
heap DQ ?

.code

main PROC
    push rbp
    mov rbp, rsp
    sub rsp, 64
    and rsp, -16                ; the entry stack is only 8-byte aligned

    lea rcx, qfreq              ; timer: read the frequency and the start tick
    call QueryPerformanceFrequency
    lea rcx, t0
    call QueryPerformanceCounter
    mov ecx, -12                ; STD_ERROR_HANDLE
    call GetStdHandle
    mov errhandle, rax

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
    mov r10, rax                ; keep the index across the divisions
    mov rax, r8
    add rax, r9                 ; i + j
    xor rdx, rdx
    mov rcx, 7
    div rcx
    mov [rdi+r10*8], rdx        ; A[i][j] = (i + j) % 7
    mov rax, r8
    imul rax, r9                ; i * j
    xor rdx, rdx
    mov rcx, 5
    div rcx
    mov [rsi+r10*8], rdx        ; B[i][j] = (i * j) % 5
    inc r9
    cmp r9, N
    jb Lfill_j
    inc r8
    cmp r8, N
    jb Lfill_i

    xor r8, r8                  ; i
Lmul_i:
    xor r9, r9                  ; j
Lmul_j:
    xor r10, r10                ; sum
    xor r11, r11                ; k
Lmul_k:
    mov rax, r8
    imul rax, rax, N
    add rax, r11                ; i * n + k
    mov rcx, [rdi+rax*8]        ; A[i][k]
    mov rax, r11
    imul rax, rax, N
    add rax, r9                 ; k * n + j
    imul rcx, [rsi+rax*8]       ; * B[k][j]
    add r10, rcx
    inc r11
    cmp r11, N
    jb Lmul_k
    mov rax, r8
    imul rax, rax, N
    add rax, r9
    mov [rbx+rax*8], r10        ; C[i][j] = sum
    inc r9
    cmp r9, N
    jb Lmul_j
    inc r8
    cmp r8, N
    jb Lmul_i

    xor rax, rax                ; total
    xor rcx, rcx
    mov rdx, ELEMS
Lsum:
    add rax, [rbx+rcx*8]
    inc rcx
    cmp rcx, rdx
    jb Lsum

    mov rbx, rax                ; park the answer: the timer call clobbers rax
    lea rcx, t1                 ; timer: stop just before the answer is printed
    call QueryPerformanceCounter

    mov rcx, rbx
    call print_u64
    mov rcx, 10
    call putc

    call report_time

    xor ecx, ecx
    call ExitProcess
main ENDP

; report_time: write "TIME_MS=<ms>" to stderr, where <ms> is the elapsed
; QueryPerformanceCounter ticks (t1-t0) scaled by the counter frequency.
; ---------------------------------------------------------------------------
report_time PROC
    sub rsp, 40
    mov rax, t1
    sub rax, t0
    mov r10, 1000
    mul r10                     ; rdx:rax = elapsed ticks * 1000
    mov r11, qfreq
    test r11, r11
    jz Lrt_zero
    div r11                     ; rax = whole milliseconds, rdx = the sub-ms remainder
    mov twhole, rax
    mov rax, rdx
    mov r10, 1000
    mul r10
    div r11                     ; rax = the three fractional digits
    mov tfrac, rax
    jmp Lrt_fmt
Lrt_zero:
    mov twhole, 0
    mov tfrac, 0
Lrt_fmt:
    lea rsi, tnumbuf+40
    mov byte ptr [rsi-1], 10    ; the line's trailing newline
    dec rsi
    mov r10, 10
    mov r8, 3
Lrt_frac:
    mov rax, tfrac
    xor rdx, rdx
    div r10
    mov tfrac, rax
    add dl, '0'
    dec rsi
    mov [rsi], dl
    dec r8
    jnz Lrt_frac
    mov byte ptr [rsi-1], '.'
    dec rsi
    mov rax, twhole
Lrt_whole:
    xor rdx, rdx
    div r10
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz Lrt_whole
    lea r8, tmsg
    mov r9, 8
Lrt_pfx:
    dec r9
    mov al, byte ptr [r8+r9]
    dec rsi
    mov [rsi], al
    test r9, r9
    jnz Lrt_pfx
    mov rdx, rsi
    lea r8, tnumbuf+40
    sub r8, rdx
    mov rcx, errhandle
    lea r9, written
    mov qword ptr [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret
report_time ENDP

; ---------------------------------------------------------------------------
; print the unsigned 64-bit value in rcx as decimal
; ---------------------------------------------------------------------------
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
