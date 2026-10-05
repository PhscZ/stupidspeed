; task 15 file_write — expected output: 52428800
; build: nasm -f win64 15_file_write.asm -o 15_file_write.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 15_file_write.obj kernel32.lib
; run: prog.exe    (from this directory)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.
; Writes the 1 MiB pattern buffer 50 times to out.bin with CreateFileA/WriteFile,
; closes it, then prints the number of bytes written. kernel32 has no fsync on a
; file handle, so this row flushes by closing, the same deviation Tcl, D, Julia,
; Nim, Dart, Pascal and others note.

default rel
global main

extern GetStdHandle
extern WriteFile
extern ExitProcess
extern QueryPerformanceCounter
extern QueryPerformanceFrequency
extern CreateFileA
extern CloseHandle

section .text
main:
    and rsp, -16
    sub rsp, 64

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

    ; h = CreateFileA("out.bin", GENERIC_WRITE, 0, NULL,
    ;                 CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL)
    lea rcx, [fname]
    mov edx, 0x40000000         ; GENERIC_WRITE
    xor r8d, r8d                ; dwShareMode = 0
    xor r9d, r9d                ; lpSecurityAttributes = NULL
    mov qword [rsp+32], 2       ; CREATE_ALWAYS
    mov qword [rsp+40], 0x80    ; FILE_ATTRIBUTE_NORMAL
    mov qword [rsp+48], 0       ; hTemplateFile = NULL
    call CreateFileA
    mov r12, rax                ; hFile

    ; buffer = 0,1,2,...,255 repeated 4096 times, built by doubling
    lea r14, [chunk]
    xor rcx, rcx
.init:
    mov [r14+rcx], cl           ; buf[i] = i
    inc rcx
    cmp rcx, 256
    jb .init
    mov rbx, 256
.double:
    cmp rbx, 1048576
    jae .write
    mov rsi, r14
    lea rdi, [r14+rbx]
    mov rcx, rbx
    rep movsb
    add rbx, rbx
    jmp .double

.write:
    xor r13, r13                ; bytes written
    mov rbx, 50
.loop:
    mov rcx, r12
    mov rdx, r14
    mov r8d, 1048576
    lea r9, [written]
    mov qword [rsp+32], 0       ; lpOverlapped = NULL
    call WriteFile
    mov eax, [written]
    add r13, rax
    dec rbx
    jnz .loop

    mov rcx, r12
    call CloseHandle

    lea rcx, [t1]               ; timer: stop just before the answer is printed
    call QueryPerformanceCounter

    mov rdi, r13
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
fname: db 'out.bin', 0
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
chunk:   resb 1048576
numbuf:  resb 32
charbuf: resb 1
written: resd 1
stdout:  resq 1
