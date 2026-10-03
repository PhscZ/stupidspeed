; task 07 string_append — expected output: 250000
; build: nasm -f win64 07_string_append.asm -o 07_string_append.obj
;        set LIB=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
;        "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe" /nologo /subsystem:console /entry:main /out:prog.exe 07_string_append.obj kernel32.lib
; run: prog.exe    (from this directory)
; Windows x64 only: PE32+ console executable, nasm -f win64 + MSVC link.exe, kernel32.dll only.
; text = text + "x" is emulated the plain way: the whole current string is
; copied into the other buffer, so the append is quadratic, exactly the point.

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

    mov rdi, rbx                ; length of text
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
bufA:    resb 250008
bufB:    resb 250008
numbuf:  resb 32
charbuf: resb 1
written: resd 1
stdout:  resq 1
