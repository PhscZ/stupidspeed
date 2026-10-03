; task 02 switch_case — expected output: 7500000075000000
; build: nasm -f win64 02_switch_case.asm -o 02_switch_case.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 02_switch_case.obj kernel32.lib
; run: prog.exe    (from this directory)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.
; The switch is a real jump table over i & 3, not an if chain.

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

    xor r12, r12                ; i
    xor r13, r13                ; acc
    mov r14, 100000000

loop02:
    mov rax, r12
    and eax, 3                  ; i mod 4
    lea rcx, [jtab]
    mov edx, dword [rcx+rax*4]
    add rdx, rcx
    jmp rdx

; the switch table: 32-bit self-relative offsets to the four cases
jtab:
    dd case0 - jtab
    dd case1 - jtab
    dd case2 - jtab
    dd case3 - jtab

case0:
    inc r13                     ; acc += 1
    jmp next02
case1:
    add r13, r12                ; acc += i
    jmp next02
case2:
    lea rdx, [r12+r12]          ; 2*i
    add r13, rdx                ; acc += 2*i
    jmp next02
case3:
    lea rdx, [r12+r12*2]        ; 3*i
    add r13, rdx                ; acc += 3*i

next02:
    inc r12
    cmp r12, r14
    jb loop02

    mov rdi, r13
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
