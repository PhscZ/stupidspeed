; task 12 matrix_add — expected output: 63984000000
; build: llc -O2 -filetype=obj -o prog.obj 12_matrix_add.ll
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
  %A = call ptr @malloc(i64 128000000)
  %B = call ptr @malloc(i64 128000000)
  %C = call ptr @malloc(i64 128000000)
  br label %init.i

; ---- A[i*n+j] = i+j ; B[i*n+j] = i-j ---------------------------------------
init.i:                                           ; preds = %init.i.cont, %entry
  %ii = phi i64 [ 0, %entry ], [ %ii.next, %init.i.cont ]
  %iic = icmp slt i64 %ii, 4000
  br i1 %iic, label %init.j, label %fill.i

init.j:                                           ; preds = %init.j.cont, %init.i
  %ij = phi i64 [ 0, %init.i ], [ %ij.next, %init.j.cont ]
  %ijc = icmp slt i64 %ij, 4000
  br i1 %ijc, label %init.j.body, label %init.i.cont

init.j.body:                                      ; preds = %init.j
  %iro = mul i64 %ii, 4000
  %iidx = add i64 %iro, %ij
  %pa = getelementptr i64, ptr %A, i64 %iidx
  %asum = add i64 %ii, %ij
  store i64 %asum, ptr %pa
  %pb = getelementptr i64, ptr %B, i64 %iidx
  %bdif = sub i64 %ii, %ij
  store i64 %bdif, ptr %pb
  br label %init.j.cont

init.j.cont:                                      ; preds = %init.j.body
  %ij.next = add i64 %ij, 1
  br label %init.j

init.i.cont:                                      ; preds = %init.j
  %ii.next = add i64 %ii, 1
  br label %init.i

; ---- C[i*n+j] = A[i*n+j] + B[i*n+j] ----------------------------------------
fill.i:                                           ; preds = %fill.i.cont, %init.i
  %fi = phi i64 [ 0, %init.i ], [ %fi.next, %fill.i.cont ]
  %fic = icmp slt i64 %fi, 4000
  br i1 %fic, label %fill.j, label %sum.init

fill.j:                                           ; preds = %fill.j.cont, %fill.i
  %fj = phi i64 [ 0, %fill.i ], [ %fj.next, %fill.j.cont ]
  %fjc = icmp slt i64 %fj, 4000
  br i1 %fjc, label %fill.j.body, label %fill.i.cont

fill.j.body:                                      ; preds = %fill.j
  %fro = mul i64 %fi, 4000
  %fidx = add i64 %fro, %fj
  %fpa = getelementptr i64, ptr %A, i64 %fidx
  %av = load i64, ptr %fpa
  %fpb = getelementptr i64, ptr %B, i64 %fidx
  %bv = load i64, ptr %fpb
  %cv = add i64 %av, %bv
  %fpc = getelementptr i64, ptr %C, i64 %fidx
  store i64 %cv, ptr %fpc
  br label %fill.j.cont

fill.j.cont:                                      ; preds = %fill.j.body
  %fj.next = add i64 %fj, 1
  br label %fill.j

fill.i.cont:                                      ; preds = %fill.j
  %fi.next = add i64 %fi, 1
  br label %fill.i

; ---- total over all 16000000 elements of C ---------------------------------
sum.init:                                         ; preds = %fill.i
  br label %sum

sum:                                              ; preds = %sum.body, %sum.init
  %sk = phi i64 [ 0, %sum.init ], [ %sk.next, %sum.body ]
  %total = phi i64 [ 0, %sum.init ], [ %total.next, %sum.body ]
  %skc = icmp slt i64 %sk, 16000000
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
