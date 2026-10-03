; task 05 alloc_churn — expected output: 1274991808
; build: nasm -f win64 05_alloc_churn.asm -o 05_alloc_churn.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 05_alloc_churn.obj kernel32.lib
; run: prog.exe    (from this directory)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.
; Every iteration is a real VirtualAlloc of 64 bytes plus the VirtualFree of the
; buffer it replaces, so this one is kernel call bound by construction. Both are
; kernel32 exports; nothing but kernel32 is imported.

default rel
global main

extern GetStdHandle
extern WriteFile
extern ExitProcess
extern VirtualAlloc
extern VirtualFree

section .text
main:
    and rsp, -16
    sub rsp, 48
    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [stdout], rax

    lea rbx, [slots]            ; 256 buffer slots
    xor r12, r12                ; i
    xor r13, r13                ; total

.loop:
    xor ecx, ecx                ; lpAddress = NULL
    mov edx, 64                 ; dwSize = 64 bytes
    mov r8d, 0x3000             ; MEM_COMMIT | MEM_RESERVE
    mov r9d, 4                  ; PAGE_READWRITE
    call VirtualAlloc
    mov r15, rax                ; fresh 64 byte buffer

    mov rcx, r12
    and ecx, 255                ; i mod 256
    mov edx, r12d
    and edx, 255
    mov [r15], dl               ; buf[0] = i mod 256
    add r13, rdx                ; total += buf[0]

    mov r14, [rbx+rcx*8]        ; the buffer this slot replaces
    test r14, r14
    jz .store
    mov rcx, r14                ; VirtualFree(old, 0, MEM_RELEASE)
    xor edx, edx
    mov r8d, 0x8000
    call VirtualFree

.store:
    mov rcx, r12
    and ecx, 255
    mov [rbx+rcx*8], r15        ; slots[i mod 256] = buf

    inc r12
    cmp r12, 10000000
    jb .loop

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
slots:   resq 256
numbuf:  resb 32
charbuf: resb 1
written: resd 1
stdout:  resq 1
