; task 08 average — expected output: 0.498046875
; build: llc -O2 -filetype=obj -o prog.obj 08_average.ll
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
; note: the accumulator is a double and the sum is taken in loop order with plain
;       fadd (no reassociation), so the mean prints exactly like the C reference:
;       printf("%.9f\n", total / 200000000.0).

target triple = "x86_64-pc-windows-msvc"

@ofmt = private unnamed_addr constant [6 x i8] c"%.9f\0A\00"
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

define i32 @main() {
entry:
  call void @t_start()
  br label %loop

loop:                                             ; preds = %entry, %loop
  %i = phi i64 [ 0, %entry ], [ %i.next, %loop ]
  %total = phi double [ 0.0, %entry ], [ %total.next, %loop ]
  %m = srem i64 %i, 256
  %d = sitofp i64 %m to double
  %reading = fdiv double %d, 256.0
  %total.next = fadd double %total, %reading
  %i.next = add i64 %i, 1
  %c = icmp slt i64 %i.next, 200000000
  br i1 %c, label %loop, label %end

end:                                              ; preds = %loop
  call void @t_report()
  %avg = fdiv double %total.next, 200000000.0
  %pr = call i32 (ptr, ...) @printf(ptr @ofmt, double %avg)
  ret i32 0
}
