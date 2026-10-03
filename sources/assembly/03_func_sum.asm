; task 03 func_sum — expected output: 100000000
; build: nasm -f win64 03_func_sum.asm -o 03_func_sum.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 03_func_sum.obj kernel32.lib
; run: prog.exe    (from this directory)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.
; Assembly never inlines: the call below is a real call, 100000000 times.

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

    xor edi, edi                ; value = 0
    mov r12, 100000000

.loop:
    call add_one                ; value = add_one(value)
    dec r12
    jnz .loop

    call print_u64              ; rdi holds value
    mov rdi, 10
    call putc

    xor ecx, ecx                ; exit
    call ExitProcess

; ---------------------------------------------------------------------------
; add_one(n) = n + 1, argument and result in rdi
add_one:
    lea rdi, [rdi+1]
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
numbuf:  resb 32
charbuf: resb 1
written: resd 1
stdout:  resq 1
