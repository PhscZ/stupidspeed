; task 01 branches — expected output: 33333334 13333333 7619048 45714285
; build: fasm 01_branches.asm 01_branches.exe    (FASM.EXE from tools/fasm, run with
;        tools/fasm/INCLUDE as the working directory so the standard includes resolve)
; run: 01_branches.exe    (from this directory)
; Windows x64 only: PE64 console executable, flat assembler 1.73.35, kernel32.dll only.
; The third assembler row: the same fifteen programs as the `nasm` and `masm` rows, in FASM
; syntax. Like them it is freestanding — no C runtime — so output is WriteFile on the handle
; GetStdHandle returns, through a hand-rolled decimal printer.
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

    xor r8, r8                  ; a
    xor r9, r9                  ; b
    xor r10, r10                ; c
    xor r14, r14                ; d
    xor r12, r12                ; i
    mov r13, 100000000

.loop:
    mov rax, r12
    xor rdx, rdx
    mov rcx, 3
    div rcx
    test rdx, rdx
    jz .count_a
    mov rax, r12
    xor rdx, rdx
    mov rcx, 5
    div rcx
    test rdx, rdx
    jz .count_b
    mov rax, r12
    xor rdx, rdx
    mov rcx, 7
    div rcx
    test rdx, rdx
    jz .count_c
    inc r14                     ; else: d += 1
    jmp .next
.count_a:
    inc r8                      ; divisible by 3
    jmp .next
.count_b:
    inc r9                      ; divisible by 5
    jmp .next
.count_c:
    inc r10                     ; divisible by 7
.next:
    inc r12
    cmp r12, r13
    jb .loop

    mov rbx, r8                 ; park the four counts in callee saved registers,
    mov rbp, r9                 ; because print_u64/putc use r8/r9/r10 for WriteFile
    mov r15, r10
    mov r12, r14

    lea rcx, [t1]               ; timer: stop just before the answer is printed
    call [QueryPerformanceCounter]

    mov rdi, rbx
    call print_u64
    mov rdi, ' '
    call putc
    mov rdi, rbp
    call print_u64
    mov rdi, ' '
    call putc
    mov rdi, r15
    call print_u64
    mov rdi, ' '
    call putc
    mov rdi, r12
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
