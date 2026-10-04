; task 08 average — expected output: 0.498046875
; build: nasm -f win64 08_average.asm -o 08_average.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 08_average.obj kernel32.lib
; run: prog.exe    (from this directory)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.
; The mean is printed as an exact decimal: the fraction is scaled by 1e9 and
; printed with nine digits, so no floating point formatting is needed.

default rel
global main

extern GetStdHandle
extern WriteFile
extern ExitProcess
extern QueryPerformanceCounter
extern QueryPerformanceFrequency

section .text
main:
    and rsp, -16
    sub rsp, 48

    lea rcx, [qfreq]            ; timer: read the frequency and the start tick
    call QueryPerformanceFrequency
    lea rcx, [t0]
    call QueryPerformanceCounter
    mov ecx, -12                ; STD_ERROR_HANDLE
    call GetStdHandle
    mov [stderr], rax
    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [stdout], rax

    xorpd xmm0, xmm0            ; total = 0.0
    movsd xmm2, [c256]          ; 256.0
    xor r12, r12                ; i

.loop:
    mov eax, r12d
    and eax, 255                ; i mod 256
    cvtsi2sd xmm1, eax
    divsd xmm1, xmm2            ; reading = (i mod 256) / 256.0
    addsd xmm0, xmm1            ; total += reading
    inc r12
    cmp r12, 100000000
    jb .loop

    movsd [tpark], xmm0         ; park the total across the timer call
    lea rcx, [t1]               ; timer: stop just before the answer is printed
    call QueryPerformanceCounter
    movsd xmm0, [tpark]

    divsd xmm0, [c1e8]          ; total / 100000000
    mulsd xmm0, [c1e9]          ; fraction scaled to an integer
    cvttsd2si rdi, xmm0
    call print_frac9

    call report_time

    xor ecx, ecx                ; exit
    call ExitProcess

; ---------------------------------------------------------------------------
; report_time: write "TIME_MS=<ms>" to stderr, where <ms> is the elapsed
; QueryPerformanceCounter ticks (t1-t0) scaled by the counter frequency.
; ---------------------------------------------------------------------------
report_time:
    sub rsp, 40
    mov rax, [t1]
    sub rax, [t0]
    mov r10, 1000
    mul r10                     ; rdx:rax = elapsed ticks * 1000
    mov r11, [qfreq]
    test r11, r11
    jz .zero
    div r11                     ; rax = whole milliseconds, rdx = the sub-ms remainder
    mov [twhole], rax
    mov rax, rdx
    mov r10, 1000
    mul r10
    div r11                     ; rax = the three fractional digits
    mov [tfrac], rax
    jmp .fmt
.zero:
    mov qword [twhole], 0
    mov qword [tfrac], 0
.fmt:
    lea rsi, [tnumbuf+40]
    mov byte [rsi-1], 10        ; the line's trailing newline
    dec rsi
    mov r10, 10
    mov r8, 3
.frac:
    mov rax, [tfrac]
    xor rdx, rdx
    div r10
    mov [tfrac], rax
    add dl, '0'
    dec rsi
    mov [rsi], dl
    dec r8
    jnz .frac
    mov byte [rsi-1], '.'
    dec rsi
    mov rax, [twhole]
.whole:
    xor rdx, rdx
    div r10
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz .whole
    lea r8, [tmsg]
    mov r9, 8
.pfx:
    dec r9
    mov al, [r8+r9]
    dec rsi
    mov [rsi], al
    test r9, r9
    jnz .pfx
    mov rdx, rsi
    lea r8, [tnumbuf+40]
    sub r8, rdx
    mov rcx, [stderr]
    lea r9, [written]
    mov qword [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret

; ---------------------------------------------------------------------------
; print "0." followed by the nine digits of rdi (0 .. 999999999)
print_frac9:
    sub rsp, 40
    mov byte [outbuf], '0'
    mov byte [outbuf+1], '.'
    lea rsi, [outbuf+11]
    mov byte [rsi], 10          ; newline
    mov rax, rdi
    mov r10, 10
    mov r8, 9
.digit:
    xor rdx, rdx
    div r10
    add dl, '0'
    dec rsi
    mov [rsi], dl
    dec r8
    jnz .digit
    mov rcx, [stdout]
    lea rdx, [outbuf]
    mov r8d, 12
    lea r9, [written]
    mov qword [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret

section .rodata
c256: dq 256.0
tmsg: db 'TIME_MS='
c1e8: dq 100000000.0
c1e9: dq 1000000000.0

section .bss
qfreq:   resq 1
t0:      resq 1
t1:      resq 1
twhole:  resq 1
tfrac:   resq 1
tpark:   resq 1
tnumbuf: resb 40
stderr:  resq 1
outbuf:  resb 16
written: resd 1
stdout:  resq 1
