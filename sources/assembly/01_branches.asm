; task 01 branches — expected output: 33333334 13333333 7619048 45714285
; build: nasm -f win64 01_branches.asm -o 01_branches.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 01_branches.obj kernel32.lib
; run: prog.exe    (from this directory)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.

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

    xor ecx, ecx                ; exit
    call ExitProcess

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
numbuf:  resb 32
charbuf: resb 1
written: resd 1
stdout:  resq 1
