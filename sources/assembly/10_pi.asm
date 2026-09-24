; task 10 pi — expected output: 44889
; build: nasm -f elf64 10_pi.asm && ld -o prog 10_pi.o    run: ./prog
; Linux x86-64 only: freestanding ELF64, nasm + ld, no libc.
;
; Gibbons' unbounded spigot for the decimal digits of pi, on hand written big
; integers. A number is a sign, a limb count and u64 limbs in base 1000000000.
; Multiplying by a small integer is mul plus carry propagation, and the carry
; out of a limb is taken with div. The two digit estimates the spigot needs are
; quotients by a full sized divisor whose quotient is a single digit, so they
; are taken by repeated subtraction. Only the sum of the first 10000 digits
; (the leading 3 included) is printed.
;
;   if 4q + r - t < n*t: emit n, and
;       q,r,t,k,n,l = 10q, 10(r-n*t), t, k, (10(3q+r))/t - 10n, l
;   else:
;       q,r,t,k,n,l = q*k, (2q+r)*l, t*l, k+1, (q*(7k+2)+r*l)/(t*l), l+2
;
; 10(3q+r)/t - 10n equals (30q + 10(r-n*t))/t and q*(7k+2)+r*l equals
; (2q+r)*l + 3k*q, so neither branch needs more than the small multiplies above.

default rel
global _start

BASE  equ 1000000000
NLIMB equ 26000

section .text
_start:
    mov r15, BASE

    lea rdi, [Q]                ; q = 1
    mov qword [rdi], 0
    mov qword [rdi+8], 1
    mov qword [rdi+16], 1
    lea rdi, [R]                ; r = 0
    mov qword [rdi], 0
    mov qword [rdi+8], 0
    lea rdi, [T]                ; t = 1
    mov qword [rdi], 0
    mov qword [rdi+8], 1
    mov qword [rdi+16], 1

    mov rbx, 1                  ; k
    mov r12, 3                  ; l
    mov r13, 3                  ; n
    xor r14, r14                ; sum of the digits
    xor rbp, rbp                ; digits emitted

.main:
    ; A = 4q + r - t
    lea rdi, [A]
    lea rsi, [Q]
    mov r8, 4
    call mul_small
    lea rdi, [A]
    lea rsi, [A]
    lea rdx, [R]
    call sadd
    lea rdi, [A]
    lea rsi, [A]
    lea rdx, [T]
    call ssub
    ; B = n*t
    lea rdi, [B]
    lea rsi, [T]
    mov r8, r13
    call mul_small
    lea rsi, [A]
    lea rdx, [B]
    call sless
    test rax, rax
    jz .else

    ; ---------------- emit the digit n ----------------
    add r14, r13
    inc rbp
    cmp rbp, 10000
    je .done
    ; C = n*t
    lea rdi, [C]
    lea rsi, [T]
    mov r8, r13
    call mul_small
    ; B = 10*(r - n*t), the new r
    lea rdi, [B]
    lea rsi, [R]
    lea rdx, [C]
    call ssub
    lea rdi, [B]
    lea rsi, [B]
    mov r8, 10
    call mul_small
    ; A = 30q + r_new = 10(3q+r) - 10n*t
    lea rdi, [A]
    lea rsi, [Q]
    mov r8, 30
    call mul_small
    lea rdi, [A]
    lea rsi, [A]
    lea rdx, [B]
    call sadd
    ; n = A / t
    lea rsi, [A]
    lea rdx, [T]
    call divq
    mov r13, rax
    ; r = r_new, q = 10q
    lea rdi, [R]
    lea rsi, [B]
    call copy_bn
    lea rdi, [Q]
    lea rsi, [Q]
    mov r8, 10
    call mul_small
    jmp .main

.else:
    ; A = 2q
    lea rdi, [A]
    lea rsi, [Q]
    mov r8, 2
    call mul_small
    ; B = 2q + r
    lea rdi, [B]
    lea rsi, [A]
    lea rdx, [R]
    call sadd
    ; C = (2q+r)*l, which is the new r and part of the numerator
    lea rdi, [C]
    lea rsi, [B]
    mov r8, r12
    call mul_small
    ; D = q*3k
    lea rdi, [D]
    lea rsi, [Q]
    mov r8, rbx
    lea r8, [r8+r8*2]
    call mul_small
    ; A = C + D = q*(7k+2) + r*l
    lea rdi, [A]
    lea rsi, [C]
    lea rdx, [D]
    call sadd
    ; t = t*l
    lea rdi, [T]
    lea rsi, [T]
    mov r8, r12
    call mul_small
    ; n = A / t
    lea rsi, [A]
    lea rdx, [T]
    call divq
    mov r13, rax
    ; r = C, q = q*k, k += 1, l += 2
    lea rdi, [R]
    lea rsi, [C]
    call copy_bn
    lea rdi, [Q]
    lea rsi, [Q]
    mov r8, rbx
    call mul_small
    inc rbx
    add r12, 2
    jmp .main

.done:
    mov rdi, r14
    call print_u64
    mov rdi, 10
    call putc

    mov eax, 60                 ; exit
    xor edi, edi
    syscall

; ---------------------------------------------------------------------------
; mul_small: rdi = dst, rsi = src, r8 = small multiplier
; dst = src * r8 and keeps the sign of src; zero times anything is zero.
mul_small:
    mov r9, [rsi+8]             ; src limb count
    test r8, r8
    jz .zero
    mov rax, [rsi]
    mov [rdi], rax              ; dst keeps the sign of src
    test r9, r9
    jz .zerolen
    xor r10, r10                ; carry
    xor r11, r11                ; limb index
.loop:
    mov rax, [rsi+16+r11*8]
    imul rax, r8
    add rax, r10
    xor rdx, rdx
    div r15                     ; rax = carry out, rdx = limb
    mov [rdi+16+r11*8], rdx
    mov r10, rax
    inc r11
    cmp r11, r9
    jb .loop
    test r10, r10
    jz .fin
    mov [rdi+16+r9*8], r10
    inc r9
.fin:
    mov [rdi+8], r9
    ret
.zerolen:
    mov qword [rdi+8], 0
    ret
.zero:
    mov qword [rdi], 0
    mov qword [rdi+8], 0
    ret

; ---------------------------------------------------------------------------
; cmp_mag: rsi = a, rdx = b -> rax = 1 if |a| > |b|, -1 if |a| < |b|, else 0
cmp_mag:
    mov r9, [rsi+8]
    mov r10, [rdx+8]
    mov r11, r9
    cmp r10, r11
    jbe .n
    mov r11, r10
.n:
    test r11, r11
    jz .eq
.loop:
    dec r11
    xor eax, eax
    cmp r11, r9
    jae .noa
    mov rax, [rsi+16+r11*8]
.noa:
    xor ecx, ecx
    cmp r11, r10
    jae .nob
    mov rcx, [rdx+16+r11*8]
.nob:
    cmp rax, rcx
    ja .gt
    jb .lt
    test r11, r11
    jnz .loop
.eq:
    xor eax, eax
    ret
.gt:
    mov eax, 1
    ret
.lt:
    mov rax, -1
    ret

; ---------------------------------------------------------------------------
; add_mag: rdi = dst, rsi = a, rdx = b -> dst = |a| + |b|
add_mag:
    mov r9, [rsi+8]
    mov r10, [rdx+8]
    mov r11, r9
    cmp r10, r11
    jbe .n
    mov r11, r10
.n:
    xor r8, r8                  ; carry
    xor ecx, ecx                ; limb index
    test r11, r11
    jz .fin
.loop:
    xor eax, eax
    cmp rcx, r9
    jae .noa
    mov rax, [rsi+16+rcx*8]
.noa:
    cmp rcx, r10
    jae .nob
    add rax, [rdx+16+rcx*8]
.nob:
    add rax, r8
    xor r8, r8
    cmp rax, r15
    jb .noc
    sub rax, r15
    mov r8, 1
.noc:
    mov [rdi+16+rcx*8], rax
    inc rcx
    cmp rcx, r11
    jb .loop
.fin:
    test r8, r8
    jz .store
    mov [rdi+16+r11*8], r8
    inc r11
.store:
    mov qword [rdi], 0
    mov [rdi+8], r11
    ret

; ---------------------------------------------------------------------------
; sub_mag: rdi = dst, rsi = a, rdx = b -> dst = |a| - |b|, needs |a| >= |b|
sub_mag:
    push rbx
    mov r9, [rsi+8]
    mov r10, [rdx+8]
    xor r8, r8                  ; borrow
    xor ecx, ecx                ; limb index
    test r9, r9
    jz .store
.loop:
    mov rax, [rsi+16+rcx*8]
    xor ebx, ebx
    cmp rcx, r10
    jae .nob
    mov rbx, [rdx+16+rcx*8]
.nob:
    xor r11d, r11d              ; borrow out of this limb
    sub rax, rbx
    jnc .b2
    mov r11d, 1
.b2:
    sub rax, r8
    jnc .b3
    mov r11d, 1
.b3:
    test r11d, r11d
    jz .noadj
    add rax, r15                ; borrow wrapped in 2^64, put back the base
.noadj:
    mov [rdi+16+rcx*8], rax
    mov r8, r11
    inc rcx
    cmp rcx, r9
    jb .loop
.store:
    mov qword [rdi], 0
    mov [rdi+8], r9
    pop rbx
    ret

; ---------------------------------------------------------------------------
; copy_bn: rdi = dst, rsi = src
copy_bn:
    mov rax, [rsi+8]
    mov r8, [rsi]
    mov [rdi], r8
    mov [rdi+8], rax
    mov rcx, rax
    test rcx, rcx
    jz .done
    add rsi, 16
    add rdi, 16
    rep movsq
.done:
    ret

; ---------------------------------------------------------------------------
; sadd: rdi = dst, rsi = a, rdx = b -> dst = a + b
; ssub: rdi = dst, rsi = a, rdx = b -> dst = a - b
sadd:
    mov r8, [rdx]
    jmp saddcore
ssub:
    mov r8, [rdx]
    xor r8, 1
    jmp saddcore

; saddcore: rdi = dst, rsi = a, rdx = b, r8 = sign to use for b
saddcore:
    mov r9, [rsi]               ; sign of a
    cmp r9, r8
    jne .diff
    push r9
    call add_mag
    pop r9
    mov [rdi], r9
    ret
.diff:
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
    je .zero
    jl .blt
    push r9                     ; |a| > |b|, result takes the sign of a
    call sub_mag
    pop r9
    mov [rdi], r9
    ret
.blt:
    push r8                     ; |b| > |a|, result takes the sign of b
    xchg rsi, rdx
    call sub_mag
    pop r8
    mov [rdi], r8
    ret
.zero:
    mov qword [rdi], 0
    mov qword [rdi+8], 0
    ret

; ---------------------------------------------------------------------------
; sless: rsi = a, rdx = b -> rax = 1 if a < b, else 0
sless:
    mov r9, [rsi]
    mov r10, [rdx]
    cmp r9, r10
    je .same
    xor eax, eax
    test r9, r9
    jz .ret
    mov eax, 1
.ret:
    ret
.same:
    push r9
    call cmp_mag
    pop r9
    test r9, r9
    jnz .neg
    cmp rax, 0
    setl al
    movzx rax, al
    ret
.neg:
    cmp rax, 0
    setg al
    movzx rax, al
    ret

; ---------------------------------------------------------------------------
; divq: rsi = N (destroyed), rdx = D > 0 -> rax = N / D
; The quotient is a single digit in both uses, so repeated subtraction is
; enough and the remainder is not needed.
divq:
    push rbp
    xor ebp, ebp
.loop:
    call cmp_mag
    cmp rax, 0
    jl .fin
    mov rdi, rsi
    call sub_mag
    inc rbp
    jmp .loop
.fin:
    mov rax, rbp
    pop rbp
    ret

; ---------------------------------------------------------------------------
; print the unsigned 64-bit value in rdi as decimal
print_u64:
    lea rsi, [numbuf+31]
    mov rax, rdi
    mov rcx, 10
.digit:
    xor rdx, rdx
    div rcx
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz .digit
    lea rdx, [numbuf+32]
    sub rdx, rsi
    mov eax, 1                  ; write
    mov edi, 1                  ; stdout
    syscall
    ret

; ---------------------------------------------------------------------------
; write the single byte in dil
putc:
    mov [charbuf], dil
    mov eax, 1
    mov edi, 1
    lea rsi, [charbuf]
    mov edx, 1
    syscall
    ret

section .bss
Q:      resq NLIMB+4
R:      resq NLIMB+4
T:      resq NLIMB+4
A:      resq NLIMB+4
B:      resq NLIMB+4
C:      resq NLIMB+4
D:      resq NLIMB+4
numbuf:  resb 32
charbuf: resb 1

section .note.GNU-stack noalloc noexec nowrite progbits
