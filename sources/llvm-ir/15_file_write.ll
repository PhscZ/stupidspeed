; task 15 file_write — expected output: 419430400
; build: llc -O2 -filetype=obj -o prog.obj 15_file_write.ll
;        clang -O2 -fuse-ld=lld prog.obj -o prog.exe
; run: prog.exe
; note: this file is hand-written LLVM IR. The .ll text is the compiler input and
;       the source; no C was compiled to produce it.
; note: the row's standing choice, identical in all fifteen files: the C runtime
;       for formatted output, allocation and file I/O, and kernel32 directly only
;       for the clock (QueryPerformanceCounter) and, in task 11, for threads
;       (CreateThread/WaitForSingleObject/CloseHandle). This file uses libc malloc,
;       free, printf, fprintf, fopen, fwrite, fflush, fclose and the low-level
;       _fileno/_commit flush; kernel32 QueryPerformanceFrequency,
;       QueryPerformanceCounter.

target triple = "x86_64-pc-windows-msvc"

@ofmt = private unnamed_addr constant [6 x i8] c"%lld\0A\00"
@efmt = private unnamed_addr constant [21 x i8] c"TIME_MS=%lld.%03lld\0A\00"
@wname = private unnamed_addr constant [8 x i8] c"out.bin\00"
@wmode = private unnamed_addr constant [3 x i8] c"wb\00"
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
declare i64 @fwrite(ptr, i64, i64, ptr)
declare i32 @fflush(ptr)
declare i32 @_fileno(ptr)
declare i32 @_commit(i32)
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
  br label %fill

; ---- buf[i] = (i8)(i % 256) -------------------------------------------------
fill:                                             ; preds = %fill.body, %entry
  %i = phi i64 [ 0, %entry ], [ %i.next, %fill.body ]
  %ic = icmp slt i64 %i, 1048576
  br i1 %ic, label %fill.body, label %pass

fill.body:                                        ; preds = %fill
  %r = srem i64 %i, 256
  %b = trunc i64 %r to i8
  %p = getelementptr i8, ptr %buf, i64 %i
  store i8 %b, ptr %p
  %i.next = add i64 %i, 1
  br label %fill

; ---- 8 passes, each rewriting out.bin from offset 0 -------------------------
pass:                                             ; preds = %fill, %flush
  %pass.i = phi i64 [ 0, %fill ], [ %pass.next, %flush ]
  %written = phi i64 [ 0, %fill ], [ %acc, %flush ]
  %pc = icmp slt i64 %pass.i, 8
  br i1 %pc, label %open, label %done

open:                                             ; preds = %pass
  %f = call ptr @fopen(ptr @wname, ptr @wmode)
  %isnull = icmp eq ptr %f, null
  br i1 %isnull, label %fail, label %write

fail:                                             ; preds = %open
  call void @free(ptr %buf)
  ret i32 1

; ---- 50 x fwrite(buf, 1, CHUNK, f) per pass ---------------------------------
write:                                            ; preds = %write.body, %open
  %rep = phi i64 [ 0, %open ], [ %rep.next, %write.body ]
  %acc = phi i64 [ %written, %open ], [ %acc.next, %write.body ]
  %repc = icmp slt i64 %rep, 50
  br i1 %repc, label %write.body, label %flush

write.body:                                       ; preds = %write
  %nw = call i64 @fwrite(ptr %buf, i64 1, i64 1048576, ptr %f)
  %acc.next = add i64 %acc, %nw
  %rep.next = add i64 %rep, 1
  br label %write

flush:                                            ; preds = %write
  %fr = call i32 @fflush(ptr %f)
  %fd = call i32 @_fileno(ptr %f)
  %cr = call i32 @_commit(i32 %fd)
  %cl = call i32 @fclose(ptr %f)
  %pass.next = add i64 %pass.i, 1
  br label %pass

done:                                             ; preds = %pass
  call void @free(ptr %buf)
  call void @t_report()
  %p2 = call i32 (ptr, ...) @printf(ptr @ofmt, i64 %written)
  ret i32 0
}
