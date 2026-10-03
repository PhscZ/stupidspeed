; task 04 array_sum — expected output: 499999500000
; build: nasm -f win64 04_array_sum.asm -o 04_array_sum.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 04_array_sum.obj kernel32.lib
; run: prog.exe    (from this directory)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.
; The 1000000 element array is a VirtualAlloc reservation, not a .bss block.

default rel
global main

extern GetStdHandle
extern WriteFile
extern ExitProcess
extern VirtualAlloc

section .text
main:
    and rsp, -16
    sub rsp, 48
    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [stdout], rax

    ; array = VirtualAlloc(NULL, 1000000*8, MEM_COMMIT|MEM_RESERVE, PAGE_READWRITE)
    xor ecx, ecx                ; lpAddress = NULL
    mov edx, 8000000            ; dwSize
    mov r8d, 0x3000             ; MEM_COMMIT | MEM_RESERVE
    mov r9d, 4                  ; PAGE_READWRITE
    call VirtualAlloc
    mov rbx, rax                ; base of the array

    xor r12, r12                ; i
.fill:
    mov [rbx+r12*8], r12        ; array[i] = i
    inc r12
    cmp r12, 1000000
    jb .fill

    xor r13, r13                ; total
    xor r12, r12

.sum:
    add r13, [rbx+r12*8]        ; total += array[i]
    inc r12
    cmp r12, 1000000
    jb .sum

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
