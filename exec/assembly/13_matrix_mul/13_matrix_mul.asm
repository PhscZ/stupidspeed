; task 13 matrix_mul — expected output: 599995000
; build: nasm -f win64 13_matrix_mul.asm -o 13_matrix_mul.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 13_matrix_mul.obj kernel32.lib
; run: prog.exe    (from this directory)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.
; n = 500, plain i,j,k triple loop in that order, no reordering, no library.

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

    lea r14, [A]
    lea r15, [B]
    lea r13, [C]

    xor rbx, rbx                ; i
.fillA:
    xor rcx, rcx                ; j
.jA:
    mov r9, rbx
    imul r9, 500
    add r9, rcx                 ; i*n + j
    mov rax, rbx
    add rax, rcx                ; i + j
    xor rdx, rdx
    mov r8, 7
    div r8
    mov [r14+r9*8], rdx         ; A[i][j] = (i+j) mod 7
    inc rcx
    cmp rcx, 500
    jb .jA
    inc rbx
    cmp rbx, 500
    jb .fillA

    xor rbx, rbx
.fillB:
    xor rcx, rcx
.jB:
    mov r9, rbx
    imul r9, 500
    add r9, rcx
    mov rax, rbx
    imul rax, rcx               ; i * j
    xor rdx, rdx
    mov r8, 5
    div r8
    mov [r15+r9*8], rdx         ; B[i][j] = (i*j) mod 5
    inc rcx
    cmp rcx, 500
    jb .jB
    inc rbx
    cmp rbx, 500
    jb .fillB

    xor rbx, rbx                ; i
.ik:
    xor rcx, rcx                ; j
.jk:
    xor r12, r12                ; sum = 0
    xor r8, r8                  ; k
.kk:
    mov rax, rbx
    imul rax, 500
    add rax, r8                 ; i*n + k
    mov rdx, [r14+rax*8]        ; A[i][k]
    mov rax, r8
    imul rax, 500
    add rax, rcx                ; k*n + j
    imul rdx, [r15+rax*8]       ; A[i][k] * B[k][j]
    add r12, rdx
    inc r8
    cmp r8, 500
    jb .kk
    mov r9, rbx
    imul r9, 500
    add r9, rcx
    mov [r13+r9*8], r12         ; C[i][j] = sum
    inc rcx
    cmp rcx, 500
    jb .jk
    inc rbx
    cmp rbx, 500
    jb .ik

    xor r12, r12                ; sum of all C values
    xor rcx, rcx
.sum:
    add r12, [r13+rcx*8]
    inc rcx
    cmp rcx, 250000
    jb .sum

    lea rcx, [t1]               ; timer: stop just before the answer is printed
    call QueryPerformanceCounter

    mov rdi, r12
    call print_u64
    mov rdi, 10
    call putc

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
; print the unsigned 64-bit value in rdi as decimal
print_u64:
    sub rsp, 40
    lea rsi, [numbuf+32]
    mov rax, rdi
    mov r10, 10
.digit:
    xor rdx, rdx
    div r10
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz .digit
    mov rcx, [stdout]
    mov rdx, rsi
    lea r8, [numbuf+32]
    sub r8, rsi
    lea r9, [written]
    mov qword [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret

; ---------------------------------------------------------------------------
; write the single byte in dil
putc:
    sub rsp, 40
    mov [charbuf], dil
    mov rcx, [stdout]
    lea rdx, [charbuf]
    mov r8d, 1
    lea r9, [written]
    mov qword [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret

section .rodata
tmsg: db 'TIME_MS='

section .bss
qfreq:   resq 1
t0:      resq 1
t1:      resq 1
twhole:  resq 1
tfrac:   resq 1
tpark:   resq 1
tnumbuf: resb 40
stderr:  resq 1
A:       resq 250000
B:       resq 250000
C:       resq 250000
numbuf:  resb 32
charbuf: resb 1
written: resd 1
stdout:  resq 1
