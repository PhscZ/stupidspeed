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

section .text
main:
    and rsp, -16
    sub rsp, 48
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

    divsd xmm0, [c1e8]          ; total / 100000000
    mulsd xmm0, [c1e9]          ; fraction scaled to an integer
    cvttsd2si rdi, xmm0
    call print_frac9

    xor ecx, ecx                ; exit
    call ExitProcess

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
c1e8: dq 100000000.0
c1e9: dq 1000000000.0

section .bss
outbuf:  resb 16
written: resd 1
stdout:  resq 1
