; task 05 alloc_churn — expected output: 1274991808
;
; MASM x64 (ml64.exe) for Windows, no CRT and no printf: the only imports are
; kernel32.dll's GetStdHandle, WriteFile, VirtualAlloc and ExitProcess.
;
; The allowed kernel32 import set has no HeapFree, so the allocator here is
; hand-rolled: a 1 MB VirtualAlloc arena carved into 64-byte blocks with a free
; list. alloc64 hands out a block, free64 puts the block the slot replaces back
; on the free list, which is the same recycling a real allocator does for the C
; row's malloc(64)/free pair. The `slots` store keeps the block reachable, so
; the allocation cannot be dropped.
;
; build:
;   ML="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/ml64.exe"
;   LINK="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe"
;   export LIB='C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64'
;   "$ML" /nologo /c /Fo prog.obj 05_alloc_churn.asm
;   "$LINK" /nologo /subsystem:console /entry:main /out:prog.exe prog.obj kernel32.lib
; run: C:/stupidspeed/sources/masm/prog.exe   (absolute path: this shell does not resolve ./prog.exe)

OPTION CASEMAP:NONE

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN VirtualAlloc:PROC
EXTERN ExitProcess:PROC
INCLUDELIB kernel32.lib

PUBLIC main

BLKSZ  EQU 64
ARENA  EQU 1048576
ITER   EQU 10000000

.data
written DQ 0
charbuf DB 0

.data?
outhandle DQ ?
numbuf DB 32 DUP(?)
freelist DQ ?
bump DQ ?
slots DQ 256 DUP(?)

.code

; ---------------------------------------------------------------------------
; allocate one 64-byte block; the free list first, then the bump pointer
alloc64 PROC
    mov rax, [freelist]
    test rax, rax
    jz Lbump
    mov rdx, [rax]
    mov [freelist], rdx
    ret
Lbump:
    mov rax, [bump]
    lea rdx, [rax+BLKSZ]
    mov [bump], rdx
    ret
alloc64 ENDP

; ---------------------------------------------------------------------------
; release the 64-byte block in rcx onto the free list
free64 PROC
    mov rax, [freelist]
    mov [rcx], rax
    mov [freelist], rcx
    ret
free64 ENDP

; ---------------------------------------------------------------------------
main PROC
    push rbp
    mov rbp, rsp
    sub rsp, 64
    and rsp, -16                ; the entry stack is only 8-byte aligned

    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [outhandle], rax

    xor ecx, ecx                ; VirtualAlloc(NULL, ARENA, MEM_COMMIT|MEM_RESERVE, PAGE_READWRITE)
    mov edx, ARENA
    mov r8d, 03000h
    mov r9d, 04h
    call VirtualAlloc
    mov [bump], rax

    xor rbx, rbx                ; i
    xor rsi, rsi                ; total
Lloop:
    call alloc64
    mov r12, rax                ; buf
    mov rcx, rbx
    and rcx, 255                ; i % 256
    mov byte ptr [r12], cl      ; buf[0] = i % 256
    movzx rdx, byte ptr [r12]
    add rsi, rdx                ; total += buf[0]

    lea rdx, slots
    mov rdx, [rdx+rcx*8]        ; the block this slot replaces
    test rdx, rdx
    jz Lstore
    mov rcx, rdx
    call free64                 ; release it, as the C row's free does
Lstore:
    mov rcx, rbx
    and rcx, 255
    lea rdx, slots
    mov [rdx+rcx*8], r12        ; keep the block reachable

    inc rbx
    cmp rbx, ITER
    jb Lloop

    mov rcx, rsi
    call print_u64
    mov rcx, 10
    call putc

    xor ecx, ecx
    call ExitProcess
main ENDP

; ---------------------------------------------------------------------------
; print the unsigned 64-bit value in rcx as decimal
print_u64 PROC
    sub rsp, 40
    mov rax, rcx
    lea r11, numbuf+31
    mov r9, 10
Ldigit:
    xor rdx, rdx
    div r9
    add dl, '0'
    mov byte ptr [r11], dl
    dec r11
    test rax, rax
    jnz Ldigit
    inc r11
    lea r8, numbuf+32
    sub r8, r11
    mov rdx, r11
    mov rcx, [outhandle]
    lea r9, written
    mov qword ptr [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret
print_u64 ENDP

; ---------------------------------------------------------------------------
; write the single byte in cl
putc PROC
    sub rsp, 40
    mov byte ptr [charbuf], cl
    lea rdx, charbuf
    mov r8, 1
    mov rcx, [outhandle]
    lea r9, written
    mov qword ptr [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret
putc ENDP

END
