; task 11 parallel_sum — expected output: 7500000075000000
; build: nasm -f win64 11_parallel_sum.asm -o 11_parallel_sum.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 11_parallel_sum.obj kernel32.lib
; run: prog.exe    (from this directory)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.
; The four workers are real kernel threads, made with CreateThread and joined with
; WaitForSingleObject — the same two calls pthread_create/pthread_join issue underneath.
; The work is task 02's switch split into four fixed 25000000-iteration ranges, so the four
; threads together do exactly the work of task 02 and print the same number.

default rel
global main

extern GetStdHandle
extern WriteFile
extern ExitProcess
extern CreateThread
extern WaitForSingleObject
extern CloseHandle

NTHREADS        equ 4
CHUNK           equ 25000000

section .text
main:
    and rsp, -16
    sub rsp, 48
    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [stdout], rax

    lea rbx, [handles]          ; where the four thread handles land
    xor r12, r12                ; t

.spawn:
    xor ecx, ecx                ; lpThreadAttributes = NULL
    xor edx, edx                ; dwStackSize = 0 (default)
    lea r8, [worker]            ; lpStartAddress
    mov r9, r12                 ; lpParameter = t
    mov qword [rsp+32], 0       ; dwCreationFlags = 0
    mov qword [rsp+40], 0       ; lpThreadId = NULL
    call CreateThread
    mov [rbx+r12*8], rax

    inc r12
    cmp r12, NTHREADS
    jb .spawn

    ; join all four, then release the handles
    xor r12, r12
.join:
    mov rcx, [rbx+r12*8]
    mov edx, -1                 ; INFINITE
    call WaitForSingleObject
    mov rcx, [rbx+r12*8]
    call CloseHandle
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

    mov rdi, r13
    call print_u64
    mov rdi, 10
    call putc

    xor ecx, ecx                ; exit
    call ExitProcess

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
    lea rcx, [jtab]
    mov edx, dword [rcx+rax*4]
    add rdx, rcx
    jmp rdx

; the switch table: 32-bit self-relative offsets to the four cases
jtab:
    dd w_case0 - jtab
    dd w_case1 - jtab
    dd w_case2 - jtab
    dd w_case3 - jtab

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

section .bss
align 8
partials: resq NTHREADS
handles:  resq NTHREADS
numbuf:   resb 32
charbuf:  resb 1
written:  resd 1
stdout:   resq 1
