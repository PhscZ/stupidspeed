; task 14 file_read — expected output: 2389704704
; build: nasm -f win64 14_file_read.asm -o 14_file_read.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 14_file_read.obj kernel32.lib
; run: prog.exe    (from this directory, with data.bin beside it)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.
; Reads data.bin from the working directory in 1 MiB chunks with CreateFileA/ReadFile
; and prints the byte total modulo 4294967296.

default rel
global main

extern GetStdHandle
extern WriteFile
extern ExitProcess
extern QueryPerformanceCounter
extern QueryPerformanceFrequency
extern CreateFileA
extern ReadFile
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

    ; h = CreateFileA("data.bin", GENERIC_READ, FILE_SHARE_READ, NULL,
    ;                 OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
    lea rcx, [fname]
    mov edx, 0x80000000         ; GENERIC_READ
    mov r8d, 1                  ; FILE_SHARE_READ
    xor r9d, r9d                ; lpSecurityAttributes = NULL
    mov qword [rsp+32], 3       ; OPEN_EXISTING
    mov qword [rsp+40], 0x80    ; FILE_ATTRIBUTE_NORMAL
    mov qword [rsp+48], 0       ; hTemplateFile = NULL
    call CreateFileA
    mov r12, rax                ; hFile

    xor r13, r13                ; total
    lea r14, [chunk]            ; 1 MiB buffer

.read:
    mov rcx, r12
    mov rdx, r14
    mov r8d, 1048576
    lea r9, [bytesread]
    mov qword [rsp+32], 0       ; lpOverlapped = NULL
    call ReadFile
    mov eax, [bytesread]
    test eax, eax
    jz .done                    ; end of file

    xor rcx, rcx
.sum:
    movzx edx, byte [r14+rcx]
    add r13, rdx                ; total += b
    inc rcx
    cmp rcx, rax
    jb .sum
    jmp .read

.done:
    mov rcx, r12
    call CloseHandle

    mov eax, r13d               ; total mod 4294967296
    mov rdi, rax
    lea rcx, [t1]               ; timer: stop just before the answer is printed
    call QueryPerformanceCounter

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
fname: db 'data.bin', 0
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
chunk:     resb 1048576
bytesread: resd 1
numbuf:    resb 32
charbuf:   resb 1
written:   resd 1
stdout:    resq 1
