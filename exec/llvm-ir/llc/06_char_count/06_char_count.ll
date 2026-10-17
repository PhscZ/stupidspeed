; task 06 char_count — expected output: 25000000
; build: llc -O2 -filetype=obj -o prog.obj 06_char_count.ll
;        clang -O2 -fuse-ld=lld prog.obj -o prog.exe
; run: prog.exe
; note: this file is hand-written LLVM IR. The .ll text is the compiler input and
;       the source; no C was compiled to produce it.
; note: the row's standing choice, identical in all fifteen files: the C runtime
;       for formatted output, allocation and file I/O, and kernel32 directly only
;       for the clock (QueryPerformanceCounter) and, in task 11, for threads
;       (CreateThread/WaitForSingleObject/CloseHandle). This file uses libc malloc,
;       memcpy, printf, fprintf, free; kernel32 QueryPerformanceFrequency,
;       QueryPerformanceCounter.
; note: a 250000000-byte buffer is filled block by block with 10-byte memcpy calls,
;       then scanned once byte by byte counting 'h' (104); the i64 count is printed
;       with "%lld" so the line matches the C reference byte for byte.

target triple = "x86_64-pc-windows-msvc"

@blk = private unnamed_addr constant [10 x i8] c"abcdefghij"
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

define i32 @main() {
entry:
  call void @t_start()
  %text = call ptr @malloc(i64 250000000)
  br label %fill

fill:                                             ; preds = %entry, %fill
  %i = phi i64 [ 0, %entry ], [ %i.next, %fill ]
  %off = mul i64 %i, 10
  %dst = getelementptr i8, ptr %text, i64 %off
  call void @memcpy(ptr %dst, ptr @blk, i64 10)
  %i.next = add i64 %i, 1
  %fc = icmp slt i64 %i.next, 25000000
  br i1 %fc, label %fill, label %scan

scan:                                             ; preds = %fill, %scan
  %j = phi i64 [ 0, %fill ], [ %j.next, %scan ]
  %count = phi i64 [ 0, %fill ], [ %count.next, %scan ]
  %p = getelementptr i8, ptr %text, i64 %j
  %b = load i8, ptr %p
  %is = icmp eq i8 %b, 104
  %inc = zext i1 %is to i64
  %count.next = add i64 %count, %inc
  %j.next = add i64 %j, 1
  %sc = icmp slt i64 %j.next, 250000000
  br i1 %sc, label %scan, label %end

end:                                              ; preds = %scan
  call void @t_report()
  %pr = call i32 (ptr, ...) @printf(ptr @ofmt, i64 %count.next)
  call void @free(ptr %text)
  ret i32 0
}
