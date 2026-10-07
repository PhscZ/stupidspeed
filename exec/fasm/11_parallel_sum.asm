; task 11 parallel_sum — expected output: 7500000075000000
; build: fasm 11_parallel_sum.asm 11_parallel_sum.exe    (FASM.EXE from tools/fasm, run with
;        tools/fasm/INCLUDE as the working directory so the standard includes resolve)
; run:  11_parallel_sum.exe    (from this directory)
; Windows x64 only: PE64 console executable, flat assembler 1.73.35, kernel32.dll only.
; The four workers are real kernel threads, made with CreateThread and joined with
; WaitForSingleObject — the same two calls pthread_create/pthread_join issue underneath.
; The work is task 02's switch split into four fixed 25000000-iteration ranges, so the four
; threads together do exactly the work of task 02 and print the same number.
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

NTHREADS        equ 4
CHUNK           equ 25000000

    lea rbx, [handles]          ; where the four thread handles land
    xor r12, r12                ; t

.spawn:
    xor ecx, ecx                ; lpThreadAttributes = NULL
    xor edx, edx                ; dwStackSize = 0 (default)
    lea r8, [worker]            ; lpStartAddress
    mov r9, r12                 ; lpParameter = t
    mov qword [rsp+32], 0       ; dwCreationFlags = 0
    mov qword [rsp+40], 0       ; lpThreadId = NULL
    call [CreateThread]
    mov [rbx+r12*8], rax

    inc r12
    cmp r12, NTHREADS
    jb .spawn

    ; join all four, then release the handles
    xor r12, r12
.join:
    mov rcx, [rbx+r12*8]
    mov edx, -1                 ; INFINITE
    call [WaitForSingleObject]
    mov rcx, [rbx+r12*8]
    call [CloseHandle]
    inc r12
    cmp r12, NTHREADS
    jb .join

.sum:
    lea rsi, [partials]
    xor r13, r13
    xor rcx, rcx
.sloop:
    add r13, [rsi+rcx*8]
    inc rcx
    cmp rcx, NTHREADS
    jb .sloop

    lea rcx, [t1]               ; timer: stop just before the answer is printed
    call [QueryPerformanceCounter]

    mov rdi, r13
    call print_u64
    mov rdi, 10
    call putc

    call report_time

    xor ecx, ecx                ; exit
    call [ExitProcess]

; ---------------------------------------------------------------------------
; one worker: rcx = t, running on its own kernel thread. The switch is a real
; jump table over i & 3, exactly as in task 02.
worker:
    push r12
    push r13
    push r14
    push r15
    mov r12, rcx                            ; t
    imul r14, r12, CHUNK                    ; first i of this range
    lea r15, [r14+CHUNK]                    ; one past the last i
    xor r13, r13                            ; acc

w_loop:
    mov rax, r14
    and eax, 3                              ; i mod 4
    lea rcx, [jtab_w]
    mov edx, dword [rcx+rax*4]
    add rdx, rcx
    jmp rdx

; the switch table: 32-bit self-relative offsets to the four cases
jtab_w:
    dd w_case0 - jtab_w
    dd w_case1 - jtab_w
    dd w_case2 - jtab_w
    dd w_case3 - jtab_w

w_case0:
    inc r13                                 ; acc += 1
    jmp w_next
w_case1:
    add r13, r14                            ; acc += i
    jmp w_next
w_case2:
    lea rdx, [r14+r14]                      ; 2*i
    add r13, rdx
    jmp w_next
w_case3:
    lea rdx, [r14+r14*2]                    ; 3*i
    add r13, rdx

w_next:
    inc r14
    cmp r14, r15
    jb w_loop

    lea rax, [partials]
    mov [rax + r12*8], r13                  ; publish this range's partial sum

    pop r15
    pop r14
    pop r13
    pop r12
    xor eax, eax                            ; return 0; the OS ends the thread
    ret

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
align 8
partials: rq NTHREADS
handles:  rq NTHREADS
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
         ExitProcess, 'ExitProcess', \
         CreateThread, 'CreateThread', \
         WaitForSingleObject, 'WaitForSingleObject', \
         CloseHandle, 'CloseHandle'
