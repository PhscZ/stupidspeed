; task 07 string_append — expected output: 250000
; build: fasm 07_string_append.asm 07_string_append.exe    (FASM.EXE from tools/fasm, run with
;        tools/fasm/INCLUDE as the working directory so the standard includes resolve)
; run:  07_string_append.exe    (from this directory)
; Windows x64 only: PE64 console executable, flat assembler 1.73.35, kernel32.dll only.
; text = text + "x" is emulated the plain way: the whole current string is
; copied into the other buffer, so the append is quadratic, exactly the point.
; timing: QueryPerformanceCounter is the Windows high-resolution counter, read through the
;         counter frequency so the unit is milliseconds; TIME_MS goes to stderr (handle -12)
;         and stdout is unchanged.

format PE64 console

include 'win64a.inc'

entry start

section '.text' code readable executable

start:
    and rsp, -16
    sub rsp, 48

    lea rcx, [qfreq]            ; timer: read the frequency and the start tick
    call [QueryPerformanceFrequency]
    lea rcx, [t0]
    call [QueryPerformanceCounter]
    mov ecx, -12                ; STD_ERROR_HANDLE
    call [GetStdHandle]
    mov [stderr], rax
    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call [GetStdHandle]
    mov [stdout], rax

    lea r14, [bufA]             ; current text
    lea r15, [bufB]             ; new text
    xor rbx, rbx                ; length of text

.loop:
    mov rsi, r14
    mov rdi, r15
    mov rcx, rbx
    rep movsb                   ; new = copy of the old text
    mov byte [r15+rbx], 'x'     ; new = new + "x"
    inc rbx
    xchg r14, r15               ; the new buffer becomes the current text
    cmp rbx, 250000
    jb .loop

    lea rcx, [t1]               ; timer: stop just before the answer is printed
    call [QueryPerformanceCounter]

    mov rdi, rbx
    call print_u64
    mov rdi, 10
    call putc

    call report_time

    xor ecx, ecx                ; exit
    call [ExitProcess]

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
    call [WriteFile]
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
    call [WriteFile]
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
    call [WriteFile]
    add rsp, 40
    ret

section '.rodata' data readable
tmsg: db 'TIME_MS='

section '.bss' data readable writeable
qfreq:   rq 1
t0:      rq 1
t1:      rq 1
twhole:  rq 1
tfrac:   rq 1
tnumbuf: rb 40
stderr:  rq 1
bufA:    rb 250008
bufB:    rb 250008
numbuf:  rb 32
charbuf: rb 1
written: rd 1
stdout:  rq 1

section '.idata' import data readable writeable
  library kernel32, 'KERNEL32.DLL'
  import kernel32, \
         GetStdHandle, 'GetStdHandle', \
         WriteFile, 'WriteFile', \
         QueryPerformanceCounter, 'QueryPerformanceCounter', \
         QueryPerformanceFrequency, 'QueryPerformanceFrequency', \
         ExitProcess, 'ExitProcess'
