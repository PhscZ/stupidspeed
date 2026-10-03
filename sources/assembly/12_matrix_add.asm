; task 12 matrix_add — expected output: 999000000
; build: nasm -f win64 12_matrix_add.asm -o 12_matrix_add.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 12_matrix_add.obj kernel32.lib
; run: prog.exe    (from this directory)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.
; n = 1000, flat int64 arrays with index i*n+j.

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

    lea r14, [A]
    lea r15, [B]
    lea r13, [C]

    xor rbx, rbx                ; i
.fillA:
    xor rcx, rcx                ; j
.jA:
    mov rax, rbx
    imul rax, 1000
    add rax, rcx                ; i*n + j
    mov rdx, rbx
    add rdx, rcx                ; i + j
    mov [r14+rax*8], rdx
    inc rcx
    cmp rcx, 1000
    jb .jA
    inc rbx
    cmp rbx, 1000
    jb .fillA

    xor rbx, rbx
.fillB:
    xor rcx, rcx
.jB:
    mov rax, rbx
    imul rax, 1000
    add rax, rcx
    mov rdx, rbx
    sub rdx, rcx                ; i - j
    mov [r15+rax*8], rdx
    inc rcx
    cmp rcx, 1000
    jb .jB
    inc rbx
    cmp rbx, 1000
    jb .fillB

    xor rbx, rbx
.addC:
    xor rcx, rcx
.jC:
    mov rax, rbx
    imul rax, 1000
    add rax, rcx
    mov rdx, [r14+rax*8]
    add rdx, [r15+rax*8]
    mov [r13+rax*8], rdx        ; C[i][j] = A[i][j] + B[i][j]
    inc rcx
    cmp rcx, 1000
    jb .jC
    inc rbx
    cmp rbx, 1000
    jb .addC

    xor r12, r12                ; sum of all C values
    xor rcx, rcx
.sum:
    add r12, [r13+rcx*8]
    inc rcx
    cmp rcx, 1000000
    jb .sum

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
A:       resq 1000000
B:       resq 1000000
C:       resq 1000000
numbuf:  resb 32
charbuf: resb 1
written: resd 1
stdout:  resq 1
