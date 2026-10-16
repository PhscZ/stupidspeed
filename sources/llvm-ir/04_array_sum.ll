; task 04 array_sum — expected output: 599999940000000
; build: llc -O2 -filetype=obj -o prog.obj 04_array_sum.ll
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
; note: fill loop and sum loop are separate, each with phi induction variable and
;       accumulator in the loop header; the sum loop runs twelve times over the same
;       filled array; the array is released after the printf.

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
declare void @free(ptr)

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
  %array = call ptr @malloc(i64 80000000)
  br label %fill

fill:                                             ; preds = %fill.body, %entry
  %i = phi i64 [ 0, %entry ], [ %i.next, %fill.body ]
  %fc = icmp slt i64 %i, 10000000
  br i1 %fc, label %fill.body, label %sum.init

fill.body:                                        ; preds = %fill
  %fp = getelementptr i64, ptr %array, i64 %i
  store i64 %i, ptr %fp
  %i.next = add i64 %i, 1
  br label %fill

sum.init:                                         ; preds = %fill
  br label %sum.rep

sum.rep:                                          ; preds = %sum.done, %sum.init
  %r = phi i64 [ 0, %sum.init ], [ %r.next, %sum.done ]
  %total = phi i64 [ 0, %sum.init ], [ %total.acc, %sum.done ]
  br label %sum

sum:                                              ; preds = %sum.body, %sum.rep
  %j = phi i64 [ 0, %sum.rep ], [ %j.next, %sum.body ]
  %acc = phi i64 [ %total, %sum.rep ], [ %acc.next, %sum.body ]
  %sc = icmp slt i64 %j, 10000000
  br i1 %sc, label %sum.body, label %sum.done

sum.body:                                         ; preds = %sum
  %sp = getelementptr i64, ptr %array, i64 %j
  %v = load i64, ptr %sp
  %acc.next = add i64 %acc, %v
  %j.next = add i64 %j, 1
  br label %sum

sum.done:                                         ; preds = %sum
  %total.acc = add i64 %total, %acc
  %r.next = add i64 %r, 1
  %rc = icmp slt i64 %r.next, 12
  br i1 %rc, label %sum.rep, label %end

end:                                              ; preds = %sum.done
  call void @t_report()
  %p = call i32 (ptr, ...) @printf(ptr @ofmt, i64 %total.acc)
  call void @free(ptr %array)
  ret i32 0
}
