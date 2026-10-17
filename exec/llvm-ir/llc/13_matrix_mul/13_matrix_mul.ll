; task 13 matrix_mul — expected output: 599995000
; build: llc -O2 -filetype=obj -o prog.obj 13_matrix_mul.ll
;        clang -O2 -fuse-ld=lld prog.obj -o prog.exe
; run: prog.exe
; note: this file is hand-written LLVM IR. The .ll text is the compiler input and
;       the source; no C was compiled to produce it.
; note: the row's standing choice, identical in all fifteen files: the C runtime
;       for formatted output, allocation and file I/O, and kernel32 directly only
;       for the clock (QueryPerformanceCounter) and, in task 11, for threads
;       (CreateThread/WaitForSingleObject/CloseHandle). This file uses libc malloc,
;       free, printf, fprintf; kernel32 QueryPerformanceFrequency,
;       QueryPerformanceCounter.

target triple = "x86_64-pc-windows-msvc"

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

define i32 @main() {
entry:
  call void @t_start()
  %A = call ptr @malloc(i64 2000000)
  %B = call ptr @malloc(i64 2000000)
  %C = call ptr @malloc(i64 2000000)
  br label %init.i

; ---- A[i*n+j] = (i+j)%7 ; B[i*n+j] = (i*j)%5 -------------------------------
init.i:                                           ; preds = %init.i.cont, %entry
  %ii = phi i64 [ 0, %entry ], [ %ii.next, %init.i.cont ]
  %iic = icmp slt i64 %ii, 500
  br i1 %iic, label %init.j, label %mul.i

init.j:                                           ; preds = %init.j.cont, %init.i
  %ij = phi i64 [ 0, %init.i ], [ %ij.next, %init.j.cont ]
  %ijc = icmp slt i64 %ij, 500
  br i1 %ijc, label %init.j.body, label %init.i.cont

init.j.body:                                      ; preds = %init.j
  %iro = mul i64 %ii, 500
  %iidx = add i64 %iro, %ij
  %asum = add i64 %ii, %ij
  %av = srem i64 %asum, 7
  %pa = getelementptr i64, ptr %A, i64 %iidx
  store i64 %av, ptr %pa
  %bprod = mul i64 %ii, %ij
  %bv = srem i64 %bprod, 5
  %pb = getelementptr i64, ptr %B, i64 %iidx
  store i64 %bv, ptr %pb
  br label %init.j.cont

init.j.cont:                                      ; preds = %init.j.body
  %ij.next = add i64 %ij, 1
  br label %init.j

init.i.cont:                                      ; preds = %init.j
  %ii.next = add i64 %ii, 1
  br label %init.i

; ---- plain i, j, k triple loop ---------------------------------------------
mul.i:                                            ; preds = %mul.i.cont, %init.i
  %mi = phi i64 [ 0, %init.i ], [ %mi.next, %mul.i.cont ]
  %mic = icmp slt i64 %mi, 500
  br i1 %mic, label %mul.j, label %sum.init

mul.j:                                            ; preds = %mul.j.cont, %mul.i
  %mj = phi i64 [ 0, %mul.i ], [ %mj.next, %mul.j.cont ]
  %mjc = icmp slt i64 %mj, 500
  br i1 %mjc, label %mul.k, label %mul.i.cont

mul.k:                                            ; preds = %mul.k.body, %mul.j
  %mk = phi i64 [ 0, %mul.j ], [ %mk.next, %mul.k.body ]
  %msum = phi i64 [ 0, %mul.j ], [ %msum.next, %mul.k.body ]
  %mkc = icmp slt i64 %mk, 500
  br i1 %mkc, label %mul.k.body, label %mul.store

mul.k.body:                                       ; preds = %mul.k
  %airo = mul i64 %mi, 500
  %ai = add i64 %airo, %mk
  %ap = getelementptr i64, ptr %A, i64 %ai
  %av2 = load i64, ptr %ap
  %bkro = mul i64 %mk, 500
  %bi = add i64 %bkro, %mj
  %bp = getelementptr i64, ptr %B, i64 %bi
  %bv2 = load i64, ptr %bp
  %prod = mul i64 %av2, %bv2
  %msum.next = add i64 %msum, %prod
  %mk.next = add i64 %mk, 1
  br label %mul.k

mul.store:                                        ; preds = %mul.k
  %ciro = mul i64 %mi, 500
  %ci = add i64 %ciro, %mj
  %cp = getelementptr i64, ptr %C, i64 %ci
  store i64 %msum, ptr %cp
  br label %mul.j.cont

mul.j.cont:                                       ; preds = %mul.store
  %mj.next = add i64 %mj, 1
  br label %mul.j

mul.i.cont:                                       ; preds = %mul.j
  %mi.next = add i64 %mi, 1
  br label %mul.i

; ---- total over all 250000 elements of C ------------------------------------
sum.init:                                         ; preds = %mul.i
  br label %sum

sum:                                              ; preds = %sum.body, %sum.init
  %sk = phi i64 [ 0, %sum.init ], [ %sk.next, %sum.body ]
  %total = phi i64 [ 0, %sum.init ], [ %total.next, %sum.body ]
  %skc = icmp slt i64 %sk, 250000
  br i1 %skc, label %sum.body, label %end

sum.body:                                         ; preds = %sum
  %spc = getelementptr i64, ptr %C, i64 %sk
  %sv = load i64, ptr %spc
  %total.next = add i64 %total, %sv
  %sk.next = add i64 %sk, 1
  br label %sum

end:                                              ; preds = %sum
  call void @t_report()
  %p = call i32 (ptr, ...) @printf(ptr @ofmt, i64 %total)
  ret i32 0
}
