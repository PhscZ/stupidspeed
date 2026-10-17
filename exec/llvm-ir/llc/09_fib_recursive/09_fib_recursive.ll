; task 09 fib_recursive — expected output: 102334155
; build: llc -O2 -filetype=obj -o prog.obj 09_fib_recursive.ll
;        clang -O2 -fuse-ld=lld prog.obj -o prog.exe
; run: prog.exe
; note: this file is hand-written LLVM IR. The .ll text is the compiler input and
;       the source; no C was compiled to produce it.
; note: the row's standing choice, identical in all fifteen files: the C runtime
;       for formatted output, allocation and file I/O, and kernel32 directly only
;       for the clock (QueryPerformanceCounter) and, in task 11, for threads
;       (CreateThread/WaitForSingleObject/CloseHandle). This file uses libc printf,
;       fprintf; kernel32 QueryPerformanceFrequency, QueryPerformanceCounter. No
;       allocation here.
; note: @fib is the plain double-recursive definition (n < 2 returns n, otherwise
;       fib(n-1) + fib(n-2)); the ~331M calls of fib(40) are the point of the task,
;       so nothing is memoized. The i64 result is printed with "%lld".

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

define internal i64 @fib(i64 %n) {
entry:
  %c = icmp slt i64 %n, 2
  br i1 %c, label %base, label %rec

base:                                             ; preds = %entry
  ret i64 %n

rec:                                              ; preds = %entry
  %n1 = sub i64 %n, 1
  %n2 = sub i64 %n, 2
  %a = call i64 @fib(i64 %n1)
  %b = call i64 @fib(i64 %n2)
  %s = add i64 %a, %b
  ret i64 %s
}

define i32 @main() {
entry:
  call void @t_start()
  %r = call i64 @fib(i64 40)
  call void @t_report()
  %pr = call i32 (ptr, ...) @printf(ptr @ofmt, i64 %r)
  ret i32 0
}
