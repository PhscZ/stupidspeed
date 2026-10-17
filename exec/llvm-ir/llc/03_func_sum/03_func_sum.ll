; task 03 func_sum — expected output: 400000000
; build: llc -O2 -filetype=obj -o prog.obj 03_func_sum.ll
;        clang -O2 -fuse-ld=lld prog.obj -o prog.exe
; run: prog.exe
; note: this file is hand-written LLVM IR. The .ll text is the compiler input and
;       the source; no C was compiled to produce it.
; note: the row's standing choice, identical in all fifteen files: the C runtime
;       for formatted output, allocation and file I/O, and kernel32 directly only
;       for the clock (QueryPerformanceCounter) and, in task 11, for threads
;       (CreateThread/WaitForSingleObject/CloseHandle). This file uses libc printf,
;       fprintf; kernel32 QueryPerformanceFrequency, QueryPerformanceCounter.
; note: @add_one carries the `noinline` function attribute so the 1e8 calls really
;       happen; the loop induction variable and accumulator are loop-header phis.

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

; ---- the no-inline callee: the whole point of the task ----------------------
define internal i64 @add_one(i64 %n) noinline {
entry:
  %r = add i64 %n, 1
  ret i64 %r
}

define i32 @main() {
entry:
  call void @t_start()
  br label %loop

loop:                                             ; preds = %body, %entry
  %i = phi i64 [ 0, %entry ], [ %i.next, %body ]
  %value = phi i64 [ 0, %entry ], [ %value.next, %body ]
  %cond = icmp slt i64 %i, 400000000
  br i1 %cond, label %body, label %end

body:                                             ; preds = %loop
  %value.next = call i64 @add_one(i64 %value)
  %i.next = add i64 %i, 1
  br label %loop

end:                                              ; preds = %loop
  call void @t_report()
  %p = call i32 (ptr, ...) @printf(ptr @ofmt, i64 %value)
  ret i32 0
}
