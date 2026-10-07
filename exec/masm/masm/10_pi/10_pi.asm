; task 10 pi — expected output: 4470
;
; MASM x64 (ml64.exe) for Windows, no CRT and no printf: the only imports are
; kernel32.dll's GetStdHandle, WriteFile and ExitProcess.
;
; Gibbons' unbounded spigot for the decimal digits of pi, on hand written big
; integers, the same algorithm and the same limb representation as
; sources/c/10_pi.c: a number is a sign, a limb count and u64 limbs in base
; 1000000000, little-endian. Multiplying by a small integer is mul plus carry
; propagation, and the carry out of a limb is taken with div. The two digit
; estimates the spigot needs are quotients by a full sized divisor whose
; quotient is a single digit, so they are taken by repeated subtraction.
; Only the sum of the first 1000 digits (the leading 3 included) is printed.
;
;   if 4q + r - t < n*t: emit n, and
;       q,r,t,k,n,l = 10q, 10(r-n*t), t, k, (10(3q+r))/t - 10n, l
;   else:
;       q,r,t,k,n,l = q*k, (2q+r)*l, t*l, k+1, (q*(7k+2)+r*l)/(t*l), l+2
;
; 10(3q+r)/t - 10n equals (30q + 10(r-n*t))/t and q*(7k+2)+r*l equals
; (2q+r)*l + 3k*q, so neither branch needs more than the small multiplies above.
;
; build:
;   ML="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/ml64.exe"
;   LINK="C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/link.exe"
;   export LIB='C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64;C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64'
;   "$ML" /nologo /c /Fo prog.obj 10_pi.asm
;   "$LINK" /nologo /subsystem:console /entry:main /out:prog.exe prog.obj kernel32.lib
; run: C:/stupidspeed/sources/masm/prog.exe   (absolute path: this shell does not resolve ./prog.exe)

OPTION CASEMAP:NONE

EXTERN GetStdHandle:PROC
EXTERN QueryPerformanceCounter:PROC
EXTERN QueryPerformanceFrequency:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC
INCLUDELIB kernel32.lib

PUBLIC main

BASE  EQU 1000000000
NLIMB EQU 26000
NBUF  EQU NLIMB+4
DIGITS EQU 1000

; big number layout: [0] sign, [8] limb count, [16+i*8] limbs, base 1e9

.data
written DQ 0
charbuf DB 0
tmsg DB "TIME_MS="

.data?
outhandle DQ ?
qfreq DQ ?
t0 DQ ?
t1 DQ ?
twhole DQ ?
tfrac DQ ?
errhandle DQ ?
tnumbuf DB 40 DUP(?)
numbuf DB 32 DUP(?)
PI_Q DQ NBUF DUP(?)
PI_R DQ NBUF DUP(?)
PI_T DQ NBUF DUP(?)
PI_A DQ NBUF DUP(?)
PI_B DQ NBUF DUP(?)
PI_C DQ NBUF DUP(?)
PI_D DQ NBUF DUP(?)

.code

; ---------------------------------------------------------------------------
; mul_small: rdi = dst, rsi = src, r8 = small multiplier
; dst = src * r8 and keeps the sign of src; zero times anything is zero.
mul_small PROC
    mov r9, [rsi+8]             ; src limb count
    test r8, r8
    jz Lzero
    mov rax, [rsi]
    mov [rdi], rax              ; dst keeps the sign of src
    test r9, r9
    jz Lzerolen
    xor r10, r10                ; carry
    xor r11, r11                ; limb index
Lloop:
    mov rax, [rsi+16+r11*8]
    imul rax, r8
    add rax, r10
    xor rdx, rdx
    div r15                     ; rax = carry out, rdx = limb
    mov [rdi+16+r11*8], rdx
    mov r10, rax
    inc r11
    cmp r11, r9
    jb Lloop
    test r10, r10
    jz Lfin
    mov [rdi+16+r9*8], r10
    inc r9
Lfin:
    mov [rdi+8], r9
    ret
Lzerolen:
    mov qword ptr [rdi+8], 0
    ret
Lzero:
    mov qword ptr [rdi], 0
    mov qword ptr [rdi+8], 0
    ret
mul_small ENDP

; ---------------------------------------------------------------------------
; cmp_mag: rsi = a, rdx = b -> rax = 1 if |a| > |b|, -1 if |a| < |b|, else 0
cmp_mag PROC
    mov r9, [rsi+8]
    mov r10, [rdx+8]
    mov r11, r9
    cmp r10, r11
    jbe Ln
    mov r11, r10
Ln:
    test r11, r11
    jz Leq
Lloop:
    dec r11
    xor eax, eax
    cmp r11, r9
    jae Lnoa
    mov rax, [rsi+16+r11*8]
Lnoa:
    xor ecx, ecx
    cmp r11, r10
    jae Lnob
    mov rcx, [rdx+16+r11*8]
Lnob:
    cmp rax, rcx
    ja Lgt
    jb Llt
    test r11, r11
    jnz Lloop
Leq:
    xor eax, eax
    ret
Lgt:
    mov eax, 1
    ret
Llt:
    mov rax, -1
    ret
cmp_mag ENDP

; ---------------------------------------------------------------------------
; add_mag: rdi = dst, rsi = a, rdx = b -> dst = |a| + |b|
add_mag PROC
    mov r9, [rsi+8]
    mov r10, [rdx+8]
    mov r11, r9
    cmp r10, r11
    jbe Ln
    mov r11, r10
Ln:
    xor r8, r8                  ; carry
    xor rcx, rcx                ; limb index
    test r11, r11
    jz Lfin
Lloop:
    xor eax, eax
    cmp rcx, r9
    jae Lnoa
    mov rax, [rsi+16+rcx*8]
Lnoa:
    cmp rcx, r10
    jae Lnob
    add rax, [rdx+16+rcx*8]
Lnob:
    add rax, r8
    xor r8, r8
    cmp rax, r15
    jb Lnoc
    sub rax, r15
    mov r8, 1
Lnoc:
    mov [rdi+16+rcx*8], rax
    inc rcx
    cmp rcx, r11
    jb Lloop
Lfin:
    test r8, r8
    jz Lstore
    mov [rdi+16+r11*8], r8
    inc r11
Lstore:
    mov qword ptr [rdi], 0
    mov [rdi+8], r11
    ret
add_mag ENDP

; ---------------------------------------------------------------------------
; sub_mag: rdi = dst, rsi = a, rdx = b -> dst = |a| - |b|, needs |a| >= |b|
sub_mag PROC
    push rbx
    mov r9, [rsi+8]
    mov r10, [rdx+8]
    xor r8, r8                  ; borrow
    xor ecx, ecx                ; limb index
    test r9, r9
    jz Lstore
Lloop:
    mov rax, [rsi+16+rcx*8]
    xor ebx, ebx
    cmp rcx, r10
    jae Lnob
    mov rbx, [rdx+16+rcx*8]
Lnob:
    xor r11d, r11d              ; borrow out of this limb
    sub rax, rbx
    jnc Lb2
    mov r11d, 1
Lb2:
    sub rax, r8
    jnc Lb3
    mov r11d, 1
Lb3:
    test r11d, r11d
    jz Lnoadj
    add rax, r15                ; the borrow wrapped in 2^64, put the base back
Lnoadj:
    mov [rdi+16+rcx*8], rax
    mov r8, r11
    inc rcx
    cmp rcx, r9
    jb Lloop
Lstore:
    mov qword ptr [rdi], 0
    mov [rdi+8], r9
    pop rbx
    ret
sub_mag ENDP

; ---------------------------------------------------------------------------
; copy_bn: rdi = dst, rsi = src
copy_bn PROC
    mov rax, [rsi+8]
    mov r8, [rsi]
    mov [rdi], r8
    mov [rdi+8], rax
    mov rcx, rax
    test rcx, rcx
    jz Ldone
    add rsi, 16
    add rdi, 16
    rep movsq
Ldone:
    ret
copy_bn ENDP

; ---------------------------------------------------------------------------
; sadd: rdi = dst, rsi = a, rdx = b -> dst = a + b
; ssub: rdi = dst, rsi = a, rdx = b -> dst = a - b
sadd PROC
    mov r8, [rdx]
    jmp saddcore
sadd ENDP

ssub PROC
    mov r8, [rdx]
    xor r8, 1
    jmp saddcore
ssub ENDP

; saddcore: rdi = dst, rsi = a, rdx = b, r8 = sign to use for b
saddcore PROC
    mov r9, [rsi]               ; sign of a
    cmp r9, r8
    jne Ldiff
    push r9
    call add_mag
    pop r9
    mov [rdi], r9
    ret
Ldiff:
    push rdi
    push rsi
    push rdx
    push r8
    push r9
    call cmp_mag
    mov r10, rax
    pop r9
    pop r8
    pop rdx
    pop rsi
    pop rdi
    cmp r10, 0
    je Lzero
    jl Lblt
    push r9                     ; |a| > |b|, the result takes the sign of a
    call sub_mag
    pop r9
    mov [rdi], r9
    ret
Lblt:
    push r8                     ; |b| > |a|, the result takes the sign of b
    xchg rsi, rdx
    call sub_mag
    pop r8
    mov [rdi], r8
    ret
Lzero:
    mov qword ptr [rdi], 0
    mov qword ptr [rdi+8], 0
    ret
saddcore ENDP

; ---------------------------------------------------------------------------
; sless: rsi = a, rdx = b -> rax = 1 if a < b, else 0
sless PROC
    mov r9, [rsi]
    mov r10, [rdx]
    cmp r9, r10
    je Lsame
    xor eax, eax
    test r9, r9
    jz Lret
    mov eax, 1
Lret:
    ret
Lsame:
    push r9
    call cmp_mag
    pop r9
    test r9, r9
    jnz Lneg
    cmp rax, 0
    setl al
    movzx rax, al
    ret
Lneg:
    cmp rax, 0
    setg al
    movzx rax, al
    ret
sless ENDP

; ---------------------------------------------------------------------------
; divq: rsi = N (destroyed), rdx = D > 0 -> rax = N / D
; The quotient is a single digit in both uses, so repeated subtraction is
; enough and the remainder is not needed.
divq PROC
    push rbp
    xor ebp, ebp
Lloop:
    call cmp_mag
    cmp rax, 0
    jl Lfin
    mov rdi, rsi
    call sub_mag
    inc rbp
    jmp Lloop
Lfin:
    mov rax, rbp
    pop rbp
    ret
divq ENDP

; ---------------------------------------------------------------------------
main PROC
    push rbp
    mov rbp, rsp
    sub rsp, 64
    and rsp, -16                ; the entry stack is only 8-byte aligned

    lea rcx, qfreq              ; timer: read the frequency and the start tick
    call QueryPerformanceFrequency
    lea rcx, t0
    call QueryPerformanceCounter
    mov ecx, -12                ; STD_ERROR_HANDLE
    call GetStdHandle
    mov errhandle, rax

    mov ecx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [outhandle], rax

    mov r15, BASE

    lea rdi, PI_Q               ; q = 1
    mov qword ptr [rdi], 0
    mov qword ptr [rdi+8], 1
    mov qword ptr [rdi+16], 1
    lea rdi, PI_R               ; r = 0
    mov qword ptr [rdi], 0
    mov qword ptr [rdi+8], 0
    lea rdi, PI_T               ; t = 1
    mov qword ptr [rdi], 0
    mov qword ptr [rdi+8], 1
    mov qword ptr [rdi+16], 1

    mov rbx, 1                  ; k
    mov r12, 3                  ; l
    mov r13, 3                  ; n
    xor r14, r14                ; sum of the digits
    xor ebp, ebp                ; digits emitted

Lmain:
    ; A = 4q + r - t
    lea rdi, PI_A
    lea rsi, PI_Q
    mov r8, 4
    call mul_small
    lea rdi, PI_A
    lea rsi, PI_A
    lea rdx, PI_R
    call sadd
    lea rdi, PI_A
    lea rsi, PI_A
    lea rdx, PI_T
    call ssub
    ; B = n*t
    lea rdi, PI_B
    lea rsi, PI_T
    mov r8, r13
    call mul_small
    lea rsi, PI_A
    lea rdx, PI_B
    call sless
    test rax, rax
    jz Lelse

    ; ---------------- emit the digit n ----------------
    add r14, r13
    inc rbp
    cmp rbp, DIGITS
    je Ldone
    ; C = n*t
    lea rdi, PI_C
    lea rsi, PI_T
    mov r8, r13
    call mul_small
    ; B = 10*(r - n*t), the new r
    lea rdi, PI_B
    lea rsi, PI_R
    lea rdx, PI_C
    call ssub
    lea rdi, PI_B
    lea rsi, PI_B
    mov r8, 10
    call mul_small
    ; A = 30q + r_new = 10(3q+r) - 10n*t
    lea rdi, PI_A
    lea rsi, PI_Q
    mov r8, 30
    call mul_small
    lea rdi, PI_A
    lea rsi, PI_A
    lea rdx, PI_B
    call sadd
    ; n = A / t
    lea rsi, PI_A
    lea rdx, PI_T
    call divq
    mov r13, rax
    ; r = r_new, q = 10q
    lea rdi, PI_R
    lea rsi, PI_B
    call copy_bn
    lea rdi, PI_Q
    lea rsi, PI_Q
    mov r8, 10
    call mul_small
    jmp Lmain

Lelse:
    ; A = 2q
    lea rdi, PI_A
    lea rsi, PI_Q
    mov r8, 2
    call mul_small
    ; B = 2q + r
    lea rdi, PI_B
    lea rsi, PI_A
    lea rdx, PI_R
    call sadd
    ; C = (2q+r)*l, which is the new r and part of the numerator
    lea rdi, PI_C
    lea rsi, PI_B
    mov r8, r12
    call mul_small
    ; D = q*3k
    lea rdi, PI_D
    lea rsi, PI_Q
    mov r8, rbx
    lea r8, [r8+r8*2]
    call mul_small
    ; A = C + D = q*(7k+2) + r*l
    lea rdi, PI_A
    lea rsi, PI_C
    lea rdx, PI_D
    call sadd
    ; t = t*l
    lea rdi, PI_T
    lea rsi, PI_T
    mov r8, r12
    call mul_small
    ; n = A / t
    lea rsi, PI_A
    lea rdx, PI_T
    call divq
    mov r13, rax
    ; r = C, q = q*k, k += 1, l += 2
    lea rdi, PI_R
    lea rsi, PI_C
    call copy_bn
    lea rdi, PI_Q
    lea rsi, PI_Q
    mov r8, rbx
    call mul_small
    inc rbx
    add r12, 2
    jmp Lmain

Ldone:
    lea rcx, t1                 ; timer: stop just before the answer is printed
    call QueryPerformanceCounter

    mov rcx, r14
    call print_u64
    mov rcx, 10
    call putc

    call report_time

    xor ecx, ecx
    call ExitProcess
main ENDP

; report_time: write "TIME_MS=<ms>" to stderr, where <ms> is the elapsed
; QueryPerformanceCounter ticks (t1-t0) scaled by the counter frequency.
; ---------------------------------------------------------------------------
report_time PROC
    sub rsp, 40
    mov rax, t1
    sub rax, t0
    mov r10, 1000
    mul r10                     ; rdx:rax = elapsed ticks * 1000
    mov r11, qfreq
    test r11, r11
    jz Lrt_zero
    div r11                     ; rax = whole milliseconds, rdx = the sub-ms remainder
    mov twhole, rax
    mov rax, rdx
    mov r10, 1000
    mul r10
    div r11                     ; rax = the three fractional digits
    mov tfrac, rax
    jmp Lrt_fmt
Lrt_zero:
    mov twhole, 0
    mov tfrac, 0
Lrt_fmt:
    lea rsi, tnumbuf+40
    mov byte ptr [rsi-1], 10    ; the line's trailing newline
    dec rsi
    mov r10, 10
    mov r8, 3
Lrt_frac:
    mov rax, tfrac
    xor rdx, rdx
    div r10
    mov tfrac, rax
    add dl, '0'
    dec rsi
    mov [rsi], dl
    dec r8
    jnz Lrt_frac
    mov byte ptr [rsi-1], '.'
    dec rsi
    mov rax, twhole
Lrt_whole:
    xor rdx, rdx
    div r10
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz Lrt_whole
    lea r8, tmsg
    mov r9, 8
Lrt_pfx:
    dec r9
    mov al, byte ptr [r8+r9]
    dec rsi
    mov [rsi], al
    test r9, r9
    jnz Lrt_pfx
    mov rdx, rsi
    lea r8, tnumbuf+40
    sub r8, rdx
    mov rcx, errhandle
    lea r9, written
    mov qword ptr [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret
report_time ENDP

; ---------------------------------------------------------------------------
; print the unsigned 64-bit value in rcx as decimal
; ---------------------------------------------------------------------------
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
