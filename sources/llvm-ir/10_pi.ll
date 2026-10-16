; task 10 pi — expected output: 9092
; build: llc -O2 -filetype=obj -o prog.obj 10_pi.ll
;        clang -O2 -fuse-ld=lld prog.obj -o prog.exe
; run: prog.exe
; note: this file is hand-written LLVM IR. The .ll text is the compiler input and
;       the source; no C was compiled to produce it.
; note: LLVM IR has no integers wider than i128 and no arbitrary-precision library,
;       so the spigot runs on hand-written big integers: sign-magnitude,
;       little-endian 64-bit limbs, base 1e9 — the same representation as
;       sources/c/10_pi.c, limb for limb and step for step. Only the operations the
;       spigot needs are here: add, subtract, multiply by a small integer, and a
;       quotient, which is always one decimal digit and so comes out of repeated
;       subtraction. limb * small + carry stays well inside i64, so no 128-bit
;       arithmetic is used. The digits themselves are never printed, only their sum.
; note: the row's standing choice, identical in all fifteen files: the C runtime
;       for formatted output, allocation and file I/O, and kernel32 directly only
;       for the clock (QueryPerformanceCounter) and, in task 11, for threads
;       (CreateThread/WaitForSingleObject/CloseHandle). This file uses libc printf,
;       malloc, realloc, free, memcpy; kernel32 QueryPerformanceFrequency,
;       QueryPerformanceCounter.

target triple = "x86_64-pc-windows-msvc"

%Big = type { ptr, i64, i64, i32 }                ; limb, n, cap, neg

@ofmt = private unnamed_addr constant [6 x i8] c"%lld\0A\00"
@efmt = private unnamed_addr constant [21 x i8] c"TIME_MS=%lld.%03lld\0A\00"
@qpf = internal global i64 0
@qpc = internal global i64 0

declare i32 @printf(ptr, ...)
declare i32 @fprintf(ptr, ptr, ...)
declare ptr @__acrt_iob_func(i32)
declare i32 @QueryPerformanceFrequency(ptr)
declare i32 @QueryPerformanceCounter(ptr)
declare ptr @malloc(i64)
declare ptr @realloc(ptr, i64)
declare void @free(ptr)
declare void @memcpy(ptr, ptr, i64)

; ---- timing: QueryPerformanceCounter, reported to stderr as TIME_MS ---------
define internal void @t_start() {
entry:
  %a = call i32 @QueryPerformanceFrequency(ptr @qpf)
  %b = call i32 @QueryPerformanceCounter(ptr @qpc)
  ret void
}

define internal void @t_report() {
entry:
  %now = alloca i64
  %c = call i32 @QueryPerformanceCounter(ptr %now)
  %n = load i64, ptr %now
  %s = load i64, ptr @qpc
  %f = load i64, ptr @qpf
  %d = sub i64 %n, %s
  %t = mul i64 %d, 1000
  %whole = sdiv i64 %t, %f
  %m = mul i64 %d, 1000000
  %mf = sdiv i64 %m, %f
  %frac = srem i64 %mf, 1000
  %se = call ptr @__acrt_iob_func(i32 2)
  %p = call i32 (ptr, ...) @fprintf(ptr %se, ptr @efmt, i64 %whole, i64 %frac)
  ret void
}

; ---- big_init: n = 0, cap = 8, neg = 0, limb = malloc(8 * 8) ---------------
define internal void @big_init(ptr %x) {
entry:
  %lp = getelementptr %Big, ptr %x, i32 0, i32 0
  %np = getelementptr %Big, ptr %x, i32 0, i32 1
  %cp = getelementptr %Big, ptr %x, i32 0, i32 2
  %gp = getelementptr %Big, ptr %x, i32 0, i32 3
  %l = call ptr @malloc(i64 64)
  store ptr %l, ptr %lp
  store i64 0, ptr %np
  store i64 8, ptr %cp
  store i32 0, ptr %gp
  ret void
}

define internal void @big_free(ptr %x) {
entry:
  %lp = getelementptr %Big, ptr %x, i32 0, i32 0
  %l = load ptr, ptr %lp
  call void @free(ptr %l)
  store ptr null, ptr %lp
  ret void
}

; ---- big_reserve: double cap until it fits, then realloc -------------------
define internal void @big_reserve(ptr %x, i64 %need) {
entry:
  %cp = getelementptr %Big, ptr %x, i32 0, i32 2
  %cap0 = load i64, ptr %cp
  %fit = icmp ule i64 %need, %cap0
  br i1 %fit, label %ret, label %grow

grow:                                             ; preds = %double, %entry
  %cap = load i64, ptr %cp
  %small = icmp ult i64 %cap, %need
  br i1 %small, label %double, label %alloc

double:                                           ; preds = %grow
  %cap2 = mul i64 %cap, 2
  store i64 %cap2, ptr %cp
  br label %grow

alloc:                                            ; preds = %grow
  %lp = getelementptr %Big, ptr %x, i32 0, i32 0
  %old = load ptr, ptr %lp
  %cap3 = load i64, ptr %cp
  %bytes = mul i64 %cap3, 8
  %new = call ptr @realloc(ptr %old, i64 %bytes)
  store ptr %new, ptr %lp
  br label %ret

ret:                                              ; preds = %alloc, %entry
  ret void
}

; ---- big_trim: drop leading zero limbs; zero has no sign -------------------
define internal void @big_trim(ptr %x) {
entry:
  %lp = getelementptr %Big, ptr %x, i32 0, i32 0
  %np = getelementptr %Big, ptr %x, i32 0, i32 1
  %gp = getelementptr %Big, ptr %x, i32 0, i32 3
  br label %loop

loop:                                             ; preds = %dec, %entry
  %n = load i64, ptr %np
  %pos = icmp ugt i64 %n, 0
  br i1 %pos, label %check, label %zero

check:                                            ; preds = %loop
  %l = load ptr, ptr %lp
  %i = sub i64 %n, 1
  %ep = getelementptr i64, ptr %l, i64 %i
  %v = load i64, ptr %ep
  %is0 = icmp eq i64 %v, 0
  br i1 %is0, label %dec, label %fin

dec:                                              ; preds = %check
  %n1 = sub i64 %n, 1
  store i64 %n1, ptr %np
  br label %loop

zero:                                             ; preds = %loop
  store i32 0, ptr %gp
  br label %fin

fin:                                              ; preds = %zero, %check
  ret void
}

; ---- big_set: x = v -------------------------------------------------------
define internal void @big_set(ptr %x, i64 %v0) {
entry:
  %lp = getelementptr %Big, ptr %x, i32 0, i32 0
  %np = getelementptr %Big, ptr %x, i32 0, i32 1
  %gp = getelementptr %Big, ptr %x, i32 0, i32 3
  store i64 0, ptr %np
  store i32 0, ptr %gp
  br label %loop

loop:                                             ; preds = %body, %entry
  %v = phi i64 [ %v0, %entry ], [ %v2, %body ]
  %more = icmp ugt i64 %v, 0
  br i1 %more, label %body, label %end

body:                                             ; preds = %loop
  %n = load i64, ptr %np
  %need = add i64 %n, 1
  call void @big_reserve(ptr %x, i64 %need)
  %rem = urem i64 %v, 1000000000
  %l = load ptr, ptr %lp
  %ep = getelementptr i64, ptr %l, i64 %n
  store i64 %rem, ptr %ep
  %n1 = add i64 %n, 1
  store i64 %n1, ptr %np
  %v2 = udiv i64 %v, 1000000000
  br label %loop

end:                                              ; preds = %loop
  ret void
}

; ---- big_copy: dst = src --------------------------------------------------
define internal void @big_copy(ptr %dst, ptr %src) {
entry:
  %sn = getelementptr %Big, ptr %src, i32 0, i32 1
  %sg = getelementptr %Big, ptr %src, i32 0, i32 3
  %sl = getelementptr %Big, ptr %src, i32 0, i32 0
  %dn = getelementptr %Big, ptr %dst, i32 0, i32 1
  %dg = getelementptr %Big, ptr %dst, i32 0, i32 3
  %dl = getelementptr %Big, ptr %dst, i32 0, i32 0
  %n = load i64, ptr %sn
  call void @big_reserve(ptr %dst, i64 %n)
  %any = icmp ugt i64 %n, 0
  br i1 %any, label %copy, label %skip

copy:                                             ; preds = %entry
  %s = load ptr, ptr %sl
  %d = load ptr, ptr %dl
  %bytes = mul i64 %n, 8
  call void @memcpy(ptr %d, ptr %s, i64 %bytes)
  br label %skip

skip:                                             ; preds = %copy, %entry
  store i64 %n, ptr %dn
  %g = load i32, ptr %sg
  store i32 %g, ptr %dg
  ret void
}

; ---- big_cmp_mag: compare magnitudes, -1 / 0 / 1 --------------------------
define internal i32 @big_cmp_mag(ptr %a, ptr %b) {
entry:
  %anp = getelementptr %Big, ptr %a, i32 0, i32 1
  %bnp = getelementptr %Big, ptr %b, i32 0, i32 1
  %an = load i64, ptr %anp
  %bn = load i64, ptr %bnp
  %eqn = icmp eq i64 %an, %bn
  br i1 %eqn, label %loop, label %diff

diff:                                             ; preds = %entry
  %lt = icmp ult i64 %an, %bn
  %r = select i1 %lt, i32 -1, i32 1
  ret i32 %r

loop:                                             ; preds = %next, %entry
  %i = phi i64 [ %an, %entry ], [ %i1, %next ]
  %done = icmp eq i64 %i, 0
  br i1 %done, label %equal, label %cmp

cmp:                                              ; preds = %loop
  %i1 = sub i64 %i, 1
  %alp = getelementptr %Big, ptr %a, i32 0, i32 0
  %blp = getelementptr %Big, ptr %b, i32 0, i32 0
  %al = load ptr, ptr %alp
  %bl = load ptr, ptr %blp
  %ap = getelementptr i64, ptr %al, i64 %i1
  %bp = getelementptr i64, ptr %bl, i64 %i1
  %av = load i64, ptr %ap
  %bv = load i64, ptr %bp
  %ne = icmp ne i64 %av, %bv
  br i1 %ne, label %differ, label %next

differ:                                           ; preds = %cmp
  %lt2 = icmp ult i64 %av, %bv
  %r2 = select i1 %lt2, i32 -1, i32 1
  ret i32 %r2

next:                                             ; preds = %cmp
  br label %loop

equal:                                            ; preds = %loop
  ret i32 0
}

; ---- big_cmp: signed compare ----------------------------------------------
define internal i32 @big_cmp(ptr %a, ptr %b) {
entry:
  %agp = getelementptr %Big, ptr %a, i32 0, i32 3
  %bgp = getelementptr %Big, ptr %b, i32 0, i32 3
  %ag = load i32, ptr %agp
  %bg = load i32, ptr %bgp
  %differ = icmp ne i32 %ag, %bg
  br i1 %differ, label %by_sign, label %by_mag

by_sign:                                          ; preds = %entry
  %aneg = icmp ne i32 %ag, 0
  %r = select i1 %aneg, i32 -1, i32 1
  ret i32 %r

by_mag:                                           ; preds = %entry
  %c = call i32 @big_cmp_mag(ptr %a, ptr %b)
  %aneg2 = icmp ne i32 %ag, 0
  %nc = sub i32 0, %c
  %r2 = select i1 %aneg2, i32 %nc, i32 %c
  ret i32 %r2
}

; ---- big_add_mag: r = |a| + |b|, r non-negative ---------------------------
define internal void @big_add_mag(ptr %r, ptr %a, ptr %b) {
entry:
  %anp = getelementptr %Big, ptr %a, i32 0, i32 1
  %bnp = getelementptr %Big, ptr %b, i32 0, i32 1
  %an = load i64, ptr %anp
  %bn = load i64, ptr %bnp
  %agt = icmp ugt i64 %an, %bn
  %n = select i1 %agt, i64 %an, i64 %bn
  %need = add i64 %n, 1
  call void @big_reserve(ptr %r, i64 %need)
  br label %loop

loop:                                             ; preds = %nob, %entry
  %i = phi i64 [ 0, %entry ], [ %i1, %nob ]
  %carry = phi i64 [ 0, %entry ], [ %carry1, %nob ]
  %more = icmp ult i64 %i, %n
  br i1 %more, label %body, label %after

body:                                             ; preds = %loop
  %in_a = icmp ult i64 %i, %an
  br i1 %in_a, label %load_a, label %no_a

load_a:                                           ; preds = %body
  %alp = getelementptr %Big, ptr %a, i32 0, i32 0
  %al = load ptr, ptr %alp
  %ap = getelementptr i64, ptr %al, i64 %i
  %av = load i64, ptr %ap
  %s1 = add i64 %carry, %av
  br label %no_a

no_a:                                             ; preds = %load_a, %body
  %s2 = phi i64 [ %carry, %body ], [ %s1, %load_a ]
  %in_b = icmp ult i64 %i, %bn
  br i1 %in_b, label %load_b, label %no_b

load_b:                                           ; preds = %no_a
  %blp = getelementptr %Big, ptr %b, i32 0, i32 0
  %bl = load ptr, ptr %blp
  %bp = getelementptr i64, ptr %bl, i64 %i
  %bv = load i64, ptr %bp
  %s3 = add i64 %s2, %bv
  br label %no_b

no_b:                                             ; preds = %load_b, %no_a
  %s4 = phi i64 [ %s2, %no_a ], [ %s3, %load_b ]
  %over = icmp uge i64 %s4, 1000000000
  %s5 = sub i64 %s4, 1000000000
  %sv = select i1 %over, i64 %s5, i64 %s4
  %carry1 = select i1 %over, i64 1, i64 0
  %rlp = getelementptr %Big, ptr %r, i32 0, i32 0
  %rl = load ptr, ptr %rlp
  %rp = getelementptr i64, ptr %rl, i64 %i
  store i64 %sv, ptr %rp
  br label %nob

nob:                                              ; preds = %no_b
  %i1 = add i64 %i, 1
  br label %loop

after:                                            ; preds = %loop
  %rlp2 = getelementptr %Big, ptr %r, i32 0, i32 0
  %rl2 = load ptr, ptr %rlp2
  %rp2 = getelementptr i64, ptr %rl2, i64 %n
  store i64 %carry, ptr %rp2
  %rnp = getelementptr %Big, ptr %r, i32 0, i32 1
  %rnp_g = getelementptr %Big, ptr %r, i32 0, i32 3
  %has = icmp ne i64 %carry, 0
  %n1 = add i64 %n, 1
  %nn = select i1 %has, i64 %n1, i64 %n
  store i64 %nn, ptr %rnp
  store i32 0, ptr %rnp_g
  ret void
}

; ---- big_sub_mag: r = |a| - |b|, requires |a| >= |b| >= 0 ------------------
define internal void @big_sub_mag(ptr %r, ptr %a, ptr %b) {
entry:
  %anp = getelementptr %Big, ptr %a, i32 0, i32 1
  %an = load i64, ptr %anp
  call void @big_reserve(ptr %r, i64 %an)
  br label %loop

loop:                                             ; preds = %nob, %entry
  %i = phi i64 [ 0, %entry ], [ %i1, %nob ]
  %borrow = phi i64 [ 0, %entry ], [ %borrow1, %nob ]
  %more = icmp ult i64 %i, %an
  br i1 %more, label %body, label %after

body:                                             ; preds = %loop
  %bnp = getelementptr %Big, ptr %b, i32 0, i32 1
  %bn = load i64, ptr %bnp
  %in_b = icmp ult i64 %i, %bn
  br i1 %in_b, label %load_b, label %no_b

load_b:                                           ; preds = %body
  %blp = getelementptr %Big, ptr %b, i32 0, i32 0
  %bl = load ptr, ptr %blp
  %bp = getelementptr i64, ptr %bl, i64 %i
  %bv = load i64, ptr %bp
  br label %no_b

no_b:                                             ; preds = %load_b, %body
  %bv2 = phi i64 [ 0, %body ], [ %bv, %load_b ]
  %bi = add i64 %bv2, %borrow
  %alp = getelementptr %Big, ptr %a, i32 0, i32 0
  %al = load ptr, ptr %alp
  %ap = getelementptr i64, ptr %al, i64 %i
  %av = load i64, ptr %ap
  %ge = icmp uge i64 %av, %bi
  %d1 = sub i64 %av, %bi
  %t1 = add i64 %av, 1000000000
  %d2 = sub i64 %t1, %bi
  %dv = select i1 %ge, i64 %d1, i64 %d2
  %borrow1 = select i1 %ge, i64 0, i64 1
  %rlp = getelementptr %Big, ptr %r, i32 0, i32 0
  %rl = load ptr, ptr %rlp
  %rp = getelementptr i64, ptr %rl, i64 %i
  store i64 %dv, ptr %rp
  br label %nob

nob:                                              ; preds = %no_b
  %i1 = add i64 %i, 1
  br label %loop

after:                                            ; preds = %loop
  %rnp = getelementptr %Big, ptr %r, i32 0, i32 1
  %rgp = getelementptr %Big, ptr %r, i32 0, i32 3
  store i64 %an, ptr %rnp
  store i32 0, ptr %rgp
  call void @big_trim(ptr %r)
  ret void
}

; ---- big_add: r = a + b ---------------------------------------------------
define internal void @big_add(ptr %r, ptr %a, ptr %b) {
entry:
  %agp = getelementptr %Big, ptr %a, i32 0, i32 3
  %bgp = getelementptr %Big, ptr %b, i32 0, i32 3
  %rgp = getelementptr %Big, ptr %r, i32 0, i32 3
  %ag = load i32, ptr %agp
  %bg = load i32, ptr %bgp
  %same = icmp eq i32 %ag, %bg
  br i1 %same, label %add_mag, label %mixed

add_mag:                                          ; preds = %entry
  call void @big_add_mag(ptr %r, ptr %a, ptr %b)
  store i32 %ag, ptr %rgp
  call void @big_trim(ptr %r)
  ret void

mixed:                                            ; preds = %entry
  %c = call i32 @big_cmp_mag(ptr %a, ptr %b)
  %ge = icmp sge i32 %c, 0
  br i1 %ge, label %sub_ab, label %sub_ba

sub_ab:                                           ; preds = %mixed
  call void @big_sub_mag(ptr %r, ptr %a, ptr %b)
  store i32 %ag, ptr %rgp
  call void @big_trim(ptr %r)
  ret void

sub_ba:                                           ; preds = %mixed
  call void @big_sub_mag(ptr %r, ptr %b, ptr %a)
  store i32 %bg, ptr %rgp
  call void @big_trim(ptr %r)
  ret void
}

; ---- big_sub: r = a - b ---------------------------------------------------
define internal void @big_sub(ptr %r, ptr %a, ptr %b) {
entry:
  %agp = getelementptr %Big, ptr %a, i32 0, i32 3
  %bgp = getelementptr %Big, ptr %b, i32 0, i32 3
  %rgp = getelementptr %Big, ptr %r, i32 0, i32 3
  %ag = load i32, ptr %agp
  %bg = load i32, ptr %bgp
  %differ = icmp ne i32 %ag, %bg
  br i1 %differ, label %add_mag, label %same_sign

add_mag:                                          ; preds = %entry
  call void @big_add_mag(ptr %r, ptr %a, ptr %b)
  store i32 %ag, ptr %rgp
  call void @big_trim(ptr %r)
  ret void

same_sign:                                        ; preds = %entry
  %c = call i32 @big_cmp_mag(ptr %a, ptr %b)
  %ge = icmp sge i32 %c, 0
  br i1 %ge, label %sub_ab, label %sub_ba

sub_ab:                                           ; preds = %same_sign
  call void @big_sub_mag(ptr %r, ptr %a, ptr %b)
  store i32 %ag, ptr %rgp
  call void @big_trim(ptr %r)
  ret void

sub_ba:                                           ; preds = %same_sign
  call void @big_sub_mag(ptr %r, ptr %b, ptr %a)
  %ng = icmp eq i32 %ag, 0
  %nb = zext i1 %ng to i32
  store i32 %nb, ptr %rgp
  call void @big_trim(ptr %r)
  ret void
}

; ---- big_mul_small: r = a * m ---------------------------------------------
define internal void @big_mul_small(ptr %r, ptr %a, i64 %m) {
entry:
  %anp = getelementptr %Big, ptr %a, i32 0, i32 1
  %an = load i64, ptr %anp
  %mz = icmp eq i64 %m, 0
  %az = icmp eq i64 %an, 0
  %zero = or i1 %mz, %az
  br i1 %zero, label %is_zero, label %go

is_zero:                                          ; preds = %entry
  %rnp = getelementptr %Big, ptr %r, i32 0, i32 1
  %rgp = getelementptr %Big, ptr %r, i32 0, i32 3
  store i64 0, ptr %rnp
  store i32 0, ptr %rgp
  ret void

go:                                               ; preds = %entry
  %need = add i64 %an, 2
  call void @big_reserve(ptr %r, i64 %need)
  br label %loop

loop:                                             ; preds = %body, %go
  %i = phi i64 [ 0, %go ], [ %i1, %body ]
  %carry = phi i64 [ 0, %go ], [ %carry1, %body ]
  %more = icmp ult i64 %i, %an
  br i1 %more, label %body, label %spill

body:                                             ; preds = %loop
  %alp = getelementptr %Big, ptr %a, i32 0, i32 0
  %al = load ptr, ptr %alp
  %ap = getelementptr i64, ptr %al, i64 %i
  %av = load i64, ptr %ap
  %p = mul i64 %av, %m
  %p2 = add i64 %p, %carry
  %rem = urem i64 %p2, 1000000000
  %carry1 = udiv i64 %p2, 1000000000
  %rlp = getelementptr %Big, ptr %r, i32 0, i32 0
  %rl = load ptr, ptr %rlp
  %rp = getelementptr i64, ptr %rl, i64 %i
  store i64 %rem, ptr %rp
  %i1 = add i64 %i, 1
  br label %loop

spill:                                            ; preds = %carry_loop, %loop
  %nn = phi i64 [ %an, %loop ], [ %nn1, %carry_loop ]
  %cw = phi i64 [ %carry, %loop ], [ %cw1, %carry_loop ]
  %any = icmp ugt i64 %cw, 0
  br i1 %any, label %carry_loop, label %fin

carry_loop:                                       ; preds = %spill
  %rem2 = urem i64 %cw, 1000000000
  %rlp2 = getelementptr %Big, ptr %r, i32 0, i32 0
  %rl2 = load ptr, ptr %rlp2
  %rp2 = getelementptr i64, ptr %rl2, i64 %nn
  store i64 %rem2, ptr %rp2
  %nn1 = add i64 %nn, 1
  %cw1 = udiv i64 %cw, 1000000000
  br label %spill

fin:                                              ; preds = %spill
  %rnp2 = getelementptr %Big, ptr %r, i32 0, i32 1
  %rgp2 = getelementptr %Big, ptr %r, i32 0, i32 3
  %agp = getelementptr %Big, ptr %a, i32 0, i32 3
  %ag = load i32, ptr %agp
  store i64 %nn, ptr %rnp2
  store i32 %ag, ptr %rgp2
  call void @big_trim(ptr %r)
  ret void
}

; ---- big_quot: floor(a / b) by repeated subtraction, a >= 0, b > 0 --------
define internal i64 @big_quot(ptr %a, ptr %b, ptr %work) {
entry:
  %agp = getelementptr %Big, ptr %a, i32 0, i32 3
  %bgp = getelementptr %Big, ptr %b, i32 0, i32 3
  %bnp = getelementptr %Big, ptr %b, i32 0, i32 1
  %ag = load i32, ptr %agp
  %bg = load i32, ptr %bgp
  %bn = load i64, ptr %bnp
  %aneg = icmp ne i32 %ag, 0
  %bneg = icmp ne i32 %bg, 0
  %bzero = icmp eq i64 %bn, 0
  %bad1 = or i1 %aneg, %bneg
  %bad = or i1 %bad1, %bzero
  br i1 %bad, label %give_up, label %go

give_up:                                          ; preds = %entry
  ret i64 0

go:                                               ; preds = %entry
  call void @big_copy(ptr %work, ptr %b)
  br label %loop

loop:                                             ; preds = %body, %go
  %q = phi i64 [ 0, %go ], [ %q1, %body ]
  %c = call i32 @big_cmp(ptr %a, ptr %work)
  %ge = icmp sge i32 %c, 0
  br i1 %ge, label %body, label %end

body:                                             ; preds = %loop
  %q1 = add i64 %q, 1
  call void @big_add_mag(ptr %work, ptr %work, ptr %b)
  br label %loop

end:                                              ; preds = %loop
  ret i64 %q
}

; ---- main: Gibbons' unbounded spigot, the C row's loop exactly -------------
define i32 @main() {
entry:
  %q = alloca %Big
  %r = alloca %Big
  %t = alloca %Big
  %u = alloca %Big
  %v = alloca %Big
  %w = alloca %Big
  call void @big_init(ptr %q)
  call void @big_init(ptr %r)
  call void @big_init(ptr %t)
  call void @big_init(ptr %u)
  call void @big_init(ptr %v)
  call void @big_init(ptr %w)
  call void @big_set(ptr %q, i64 1)
  call void @big_set(ptr %r, i64 0)
  call void @big_set(ptr %t, i64 1)
  call void @t_start()
  br label %loop

loop:                                             ; preds = %cont, %entry
  %prod = phi i64 [ 0, %entry ], [ %prod.next, %cont ]
  %k = phi i64 [ 1, %entry ], [ %k.next, %cont ]
  %l = phi i64 [ 3, %entry ], [ %l.next, %cont ]
  %n = phi i64 [ 3, %entry ], [ %n.next, %cont ]
  %sum = phi i64 [ 0, %entry ], [ %sum.next, %cont ]
  %more = icmp slt i64 %prod, 2000
  br i1 %more, label %body, label %end

body:                                             ; preds = %loop
  call void @big_mul_small(ptr %u, ptr %q, i64 4)
  call void @big_add(ptr %u, ptr %u, ptr %r)      ; u = 4q + r
  %n1 = add i64 %n, 1
  call void @big_mul_small(ptr %v, ptr %t, i64 %n1)  ; v = (n + 1)t
  %c = call i32 @big_cmp(ptr %u, ptr %v)
  %lt = icmp slt i32 %c, 0
  br i1 %lt, label %settled, label %widen

settled:                                          ; preds = %body
  %sum1 = add i64 %sum, %n                     ; the digit n is settled
  %prod1 = add i64 %prod, 1
  call void @big_mul_small(ptr %u, ptr %q, i64 3)
  call void @big_add(ptr %u, ptr %u, ptr %r)
  call void @big_mul_small(ptr %u, ptr %u, i64 10)   ; u = 10(3q + r)
  %qt = call i64 @big_quot(ptr %u, ptr %t, ptr %w)
  %n10 = mul i64 %n, 10
  %next = sub i64 %qt, %n10
  call void @big_mul_small(ptr %v, ptr %t, i64 %n)   ; v = n t
  call void @big_sub(ptr %v, ptr %r, ptr %v)         ; v = r - n t
  call void @big_mul_small(ptr %r, ptr %v, i64 10)   ; r = 10(r - n t)
  call void @big_mul_small(ptr %q, ptr %q, i64 10)   ; q = 10q, t is unchanged
  br label %cont

widen:                                            ; preds = %body
  %k7 = mul i64 %k, 7
  %k72 = add i64 %k7, 2
  call void @big_mul_small(ptr %u, ptr %q, i64 %k72)
  call void @big_mul_small(ptr %v, ptr %r, i64 %l)
  call void @big_add(ptr %u, ptr %u, ptr %v)      ; u = q(7k + 2) + r l
  call void @big_mul_small(ptr %v, ptr %t, i64 %l)   ; v = t l
  %next2 = call i64 @big_quot(ptr %u, ptr %v, ptr %w)
  call void @big_mul_small(ptr %u, ptr %q, i64 2)
  call void @big_add(ptr %u, ptr %u, ptr %r)
  call void @big_mul_small(ptr %u, ptr %u, i64 %l)   ; u = (2q + r) l
  call void @big_copy(ptr %r, ptr %u)
  call void @big_mul_small(ptr %q, ptr %q, i64 %k)
  call void @big_mul_small(ptr %t, ptr %t, i64 %l)
  %k1 = add i64 %k, 1
  %l1 = add i64 %l, 2
  br label %cont

cont:                                             ; preds = %widen, %settled
  %prod.next = phi i64 [ %prod1, %settled ], [ %prod, %widen ]
  %k.next = phi i64 [ %k, %settled ], [ %k1, %widen ]
  %l.next = phi i64 [ %l, %settled ], [ %l1, %widen ]
  %n.next = phi i64 [ %next, %settled ], [ %next2, %widen ]
  %sum.next = phi i64 [ %sum1, %settled ], [ %sum, %widen ]
  br label %loop

end:                                              ; preds = %loop
  call void @t_report()
  %p = call i32 (ptr, ...) @printf(ptr @ofmt, i64 %sum)
  call void @big_free(ptr %q)
  call void @big_free(ptr %r)
  call void @big_free(ptr %t)
  call void @big_free(ptr %u)
  call void @big_free(ptr %v)
  call void @big_free(ptr %w)
  ret i32 0
}
