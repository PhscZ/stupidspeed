; task 11 parallel_sum — expected output: 7500000075000000
;
; MASM x64 (ml64.exe) for Windows, no CRT and no printf: the only imports are
; kernel32.dll's GetStdHandle, WriteFile, CreateThread, WaitForSingleObject,
; CloseHandle and ExitProcess.
; Four real kernel threads, one per quarter of task 02's 100000000-iteration
; range, each with its own job block; the main thread waits on all four.
;
; build:
;   ML="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/ml64.exe"
;   LINK="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe"
;   export LIB='C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64'
;   "$ML" /nologo /c /Fo prog.obj 11_parallel_sum.asm
;   "$LINK" /nologo /subsystem:console /entry:main /out:prog.exe prog.obj kernel32.lib
; run: C:/stupidspeed/sources/masm/prog.exe   (absolute path: this shell does not resolve ./prog.exe)

OPTION CASEMAP:NONE

EXTERN GetStdHandle:PROC
EXTERN QueryPerformanceCounter:PROC
EXTERN QueryPerformanceFrequency:PROC
EXTERN WriteFile:PROC
EXTERN CreateThread:PROC
EXTERN WaitForSingleObject:PROC
EXTERN CloseHandle:PROC
EXTERN ExitProcess:PROC
INCLUDELIB kernel32.lib

PUBLIC main

THREADS EQU 4
SPAN    EQU 25000000

.data
written DQ 0
charbuf DB 0
tmsg DB "TIME_MS="
wtab DQ wc0, wc1, wc2, wc3      ; task 02's four-way switch, shared by the four workers

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
jobs DQ 2*THREADS DUP(?)        ; 4 * { int64 t, int64 acc }
handles DQ THREADS DUP(?)

.code

; ---------------------------------------------------------------------------
; DWORD worker(LPVOID arg): acc = sum of the switch over this thread's range
worker PROC
    push rbx
    mov rbx, rcx                ; job block
    lea r11, wtab
    mov rax, [rbx]              ; t
    imul rax, rax, SPAN
    mov r9, rax                 ; i = t * SPAN
    add rax, SPAN
    mov r10, rax                ; hi
    xor r8, r8                  ; acc
Lloop:
    mov rax, r9
    and rax, 3                  ; i % 4
    jmp qword ptr [r11+rax*8]
wc0::
    inc r8                      ; acc += 1
    jmp Lnext
wc1::
    add r8, r9                  ; acc += i
    jmp Lnext
wc2::
    lea rdx, [r9+r9]            ; 2 * i
    add r8, rdx
    jmp Lnext
wc3::
    lea rdx, [r9+r9*2]          ; 3 * i
    add r8, rdx
Lnext:
    inc r9
    cmp r9, r10
    jb Lloop
    mov [rbx+8], r8             ; job->acc = acc
    pop rbx
    xor eax, eax
    ret
worker ENDP

; ---------------------------------------------------------------------------
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

    xor rbx, rbx                ; t
Lmk:
    mov rcx, rbx
    shl rcx, 4
    lea rdx, jobs
    add rcx, rdx                ; &jobs[t]
    mov [rcx], rbx              ; job->t = t
    mov qword ptr [rcx+8], 0    ; job->acc = 0
    mov r9, rcx                 ; lpParameter
    xor ecx, ecx                ; lpThreadAttributes = NULL
    xor edx, edx                ; dwStackSize = 0
    lea r8, worker              ; lpStartAddress
    mov qword ptr [rsp+32], 0   ; dwCreationFlags = 0
    mov qword ptr [rsp+40], 0   ; lpThreadId = NULL
    call CreateThread
    lea rdx, handles
    mov [rdx+rbx*8], rax
    inc rbx
    cmp rbx, THREADS
    jb Lmk

    xor rbx, rbx
Lwait:
    lea rdx, handles
    mov rcx, [rdx+rbx*8]
    mov edx, -1                 ; INFINITE
    call WaitForSingleObject
    lea rdx, handles
    mov rcx, [rdx+rbx*8]
    call CloseHandle
    inc rbx
    cmp rbx, THREADS
    jb Lwait

    lea rsi, jobs
    xor rbx, rbx
    xor rax, rax
Lsum:
    mov rcx, rbx
    shl rcx, 4
    add rax, [rsi+rcx+8]        ; total += jobs[t].acc
    inc rbx
    cmp rbx, THREADS
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
