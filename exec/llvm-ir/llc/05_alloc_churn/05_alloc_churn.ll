; task 05 alloc_churn — expected output: 6374991808
; build: llc -O2 -filetype=obj -o prog.obj 05_alloc_churn.ll
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
; note: @slots is a zero-initialized module-level [256 x ptr]; free(NULL) on the
;       first pass through a slot is legal and the trailing drain frees all slots.

target triple = "x86_64-pc-windows-msvc"

@ofmt = private unnamed_addr constant [6 x i8] c"%lld\0A\00"
@efmt = private unnamed_addr constant [21 x i8] c"TIME_MS=%lld.%03lld\0A\00"
@qpf = internal global i64 0
@qpc = internal global i64 0
@slots = internal global [256 x ptr] zeroinitializer

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
  br label %loop

loop:                                             ; preds = %body, %entry
  %i = phi i64 [ 0, %entry ], [ %i.next, %body ]
  %total = phi i64 [ 0, %entry ], [ %total.next, %body ]
  %cond = icmp slt i64 %i, 50000000
  br i1 %cond, label %body, label %drain

body:                                             ; preds = %loop
  %buf = call ptr @malloc(i64 64)
  %b = trunc i64 %i to i8
  store i8 %b, ptr %buf
  %z = zext i8 %b to i64
  %total.next = add i64 %total, %z
  %slot = srem i64 %i, 256
  %sp = getelementptr [256 x ptr], ptr @slots, i64 0, i64 %slot
  %old = load ptr, ptr %sp
  call void @free(ptr %old)
  store ptr %buf, ptr %sp
  %i.next = add i64 %i, 1
  br label %loop

drain:                                            ; preds = %loop
  br label %drain.loop

drain.loop:                                       ; preds = %drain.body, %drain
  %k = phi i64 [ 0, %drain ], [ %k.next, %drain.body ]
  %dc = icmp slt i64 %k, 256
  br i1 %dc, label %drain.body, label %end

drain.body:                                       ; preds = %drain.loop
  %dp = getelementptr [256 x ptr], ptr @slots, i64 0, i64 %k
  %dv = load ptr, ptr %dp
  call void @free(ptr %dv)
  %k.next = add i64 %k, 1
  br label %drain.loop

end:                                              ; preds = %drain.loop
  call void @t_report()
  %p = call i32 (ptr, ...) @printf(ptr @ofmt, i64 %total)
  ret i32 0
}
