; task 08 average — expected output: 0.498046875
;
; MASM x64 (ml64.exe) for Windows, no CRT and no printf: the only imports are
; kernel32.dll's GetStdHandle, WriteFile and ExitProcess.
; There is no printf, so the double is printed by hand: the average is scaled by
; 1e9, rounded to an integer, and printed as <int> "." <nine zero-padded digits>,
; which is the same fixed nine-decimal form the C row's "%.9f" produces.
;
; build:
;   ML="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/ml64.exe"
;   LINK="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe"
;   export LIB='C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64'
;   "$ML" /nologo /c /Fo prog.obj 08_average.asm
;   "$LINK" /nologo /subsystem:console /entry:main /out:prog.exe prog.obj kernel32.lib
; run: C:/stupidspeed/sources/masm/prog.exe   (absolute path: this shell does not resolve ./prog.exe)

OPTION CASEMAP:NONE

EXTERN GetStdHandle:PROC
EXTERN QueryPerformanceCounter:PROC
EXTERN QueryPerformanceFrequency:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC
INCLUDELIB kernel32.lib

PUBLIC main

ITER EQU 100000000

.data
written DQ 0
charbuf DB 0
tmsg DB "TIME_MS="
c256 DQ 256.0
c1e8 DQ 100000000.0
c1e9 DQ 1000000000.0

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
fracbuf DB 16 DUP(?)

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

    xorpd xmm0, xmm0            ; total = 0.0
    xor rbx, rbx                ; i
    mov rsi, ITER

Lloop:
    mov rax, rbx
    xor rdx, rdx
    mov rcx, 256
    div rcx                     ; rdx = i % 256
    cvtsi2sd xmm1, rdx          ; reading = (i % 256) / 256.0
    divsd xmm1, c256
    addsd xmm0, xmm1            ; total += reading
    inc rbx
    cmp rbx, rsi
    jb Lloop

    divsd xmm0, c1e8            ; total / 100000000.0
    mulsd xmm0, c1e9            ; scale to nine decimal places
    cvtsd2si rax, xmm0
    mov rbx, rax                ; park the answer: the timer call clobbers rax
    lea rcx, t1                 ; timer: stop just before the answer is printed
    call QueryPerformanceCounter

    mov rcx, rbx
    call print_fixed9
    mov rcx, 10
    call putc

    call report_time

    xor ecx, ecx
    call ExitProcess
main ENDP

; ---------------------------------------------------------------------------
; print the integer in rcx scaled by 1e9 as a fixed nine-decimal number
print_fixed9 PROC
    push rbx
    sub rsp, 32
    mov rax, rcx
    mov rcx, 1000000000
    xor rdx, rdx
    div rcx
    mov rbx, rdx                ; fractional part
    mov rcx, rax                ; integer part
    call print_u64
    mov rcx, '.'
    call putc

    lea r11, fracbuf+9          ; nine zero-padded digits
    mov r9, 10
    mov r10, 9
Lzero:
    mov rax, rbx
    xor rdx, rdx
    div r9
    add dl, '0'
    dec r11
    mov byte ptr [r11], dl
    mov rbx, rax
    dec r10
    jnz Lzero
    mov rcx, r11
    mov rdx, 9
    call print_bytes

    add rsp, 32
    pop rbx
    ret
print_fixed9 ENDP

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

; ---------------------------------------------------------------------------
; write rdx bytes from rcx
print_bytes PROC
    sub rsp, 40
    mov r8, rdx
    mov rdx, rcx
    mov rcx, [outhandle]
    lea r9, written
    mov qword ptr [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret
print_bytes ENDP

END
