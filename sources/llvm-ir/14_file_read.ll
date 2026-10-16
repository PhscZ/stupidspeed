; task 14 file_read — expected output: 1937768448
; build: llc -O2 -filetype=obj -o prog.obj 14_file_read.ll
;        clang -O2 -fuse-ld=lld prog.obj -o prog.exe
; run: prog.exe
; note: this file is hand-written LLVM IR. The .ll text is the compiler input and
;       the source; no C was compiled to produce it.
; note: the row's standing choice, identical in all fifteen files: the C runtime
;       for formatted output, allocation and file I/O, and kernel32 directly only
;       for the clock (QueryPerformanceCounter) and, in task 11, for threads
;       (CreateThread/WaitForSingleObject/CloseHandle). This file uses libc malloc,
;       free, printf, fprintf, fopen, fread, fclose; kernel32
;       QueryPerformanceFrequency, QueryPerformanceCounter.

target triple = "x86_64-pc-windows-msvc"

@ofmt = private unnamed_addr constant [6 x i8] c"%llu\0A\00"
@efmt = private unnamed_addr constant [21 x i8] c"TIME_MS=%lld.%03lld\0A\00"
@rname = private unnamed_addr constant [9 x i8] c"data.bin\00"
@rmode = private unnamed_addr constant [3 x i8] c"rb\00"
@qpf = internal global i64 0
@qpc = internal global i64 0

declare i32 @printf(ptr, ...)
declare i32 @fprintf(ptr, ptr, ...)
declare ptr @__acrt_iob_func(i32)
declare i32 @QueryPerformanceFrequency(ptr)
declare i32 @QueryPerformanceCounter(ptr)
declare ptr @malloc(i64)
declare void @free(ptr)
declare ptr @fopen(ptr, ptr)
declare i64 @fread(ptr, i64, i64, ptr)
declare i32 @fclose(ptr)

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
  %buf = call ptr @malloc(i64 1048576)
  br label %passinit

; ---- eight passes over data.bin, reopened at offset 0 for each pass ---------
passinit:                                         ; preds = %entry, %nextpass
  %pass = phi i32 [ 0, %entry ], [ %pass.next, %nextpass ]
  %tot.in = phi i64 [ 0, %entry ], [ %total, %nextpass ]
  %f = call ptr @fopen(ptr @rname, ptr @rmode)
  %isnull = icmp eq ptr %f, null
  br i1 %isnull, label %fail, label %cond

fail:                                             ; preds = %passinit
  ret i32 1

; ---- while ((got = fread(buf,1,CHUNK,f)) > 0) total += sum of bytes ---------
cond:                                             ; preds = %passinit, %latch
  %total = phi i64 [ %tot.in, %passinit ], [ %t.acc, %latch ]
  %got = call i64 @fread(ptr %buf, i64 1, i64 1048576, ptr %f)
  %more = icmp sgt i64 %got, 0
  br i1 %more, label %inner, label %passend

inner:                                            ; preds = %inner.body, %cond
  %i = phi i64 [ 0, %cond ], [ %i.next, %inner.body ]
  %t = phi i64 [ %total, %cond ], [ %t.next, %inner.body ]
  %ic = icmp slt i64 %i, %got
  br i1 %ic, label %inner.body, label %latch

inner.body:                                       ; preds = %inner
  %p = getelementptr i8, ptr %buf, i64 %i
  %b = load i8, ptr %p
  %z = zext i8 %b to i64
  %t.next = add i64 %t, %z
  %i.next = add i64 %i, 1
  br label %inner

latch:                                            ; preds = %inner
  %t.acc = phi i64 [ %t, %inner ]
  br label %cond

passend:                                          ; preds = %cond
  %cl = call i32 @fclose(ptr %f)
  %pass.next = add i32 %pass, 1
  %last = icmp eq i32 %pass.next, 8
  br i1 %last, label %done, label %nextpass

nextpass:                                         ; preds = %passend
  br label %passinit

done:                                             ; preds = %passend
  call void @free(ptr %buf)
  call void @t_report()
  %mod = urem i64 %total, 4294967296
  %p2 = call i32 (ptr, ...) @printf(ptr @ofmt, i64 %mod)
  ret i32 0
}
