; task 07 string_append — expected output: 750000
; build: llc -O2 -filetype=obj -o prog.obj 07_string_append.ll
;        clang -O2 -fuse-ld=lld prog.obj -o prog.exe
; run: prog.exe
; note: this file is hand-written LLVM IR. The .ll text is the compiler input and
;       the source; no C was compiled to produce it.
; note: the row's standing choice, identical in all fifteen files: the C runtime
;       for formatted output, allocation and file I/O, and kernel32 directly only
;       for the clock (QueryPerformanceCounter) and, in task 11, for threads
;       (CreateThread/WaitForSingleObject/CloseHandle). This file uses libc malloc,
;       realloc, strcat, strlen, printf, fprintf, free; kernel32
;       QueryPerformanceFrequency, QueryPerformanceCounter.
; note: the quadratic append is the point of the task: each of the 750000 rounds
;       grows the allocation by one and strcat walks the whole string, so the IR
;       keeps the realloc/strcat pair exactly as the C reference has it.

target triple = "x86_64-pc-windows-msvc"

@xstr = private unnamed_addr constant [2 x i8] c"x\00"
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
declare ptr @realloc(ptr, i64)
declare ptr @strcat(ptr, ptr)
declare i64 @strlen(ptr)
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
  %buf0 = call ptr @malloc(i64 1)
  store i8 0, ptr %buf0
  br label %loop

loop:                                             ; preds = %entry, %loop
  %i = phi i64 [ 0, %entry ], [ %i.next, %loop ]
  %len = phi i64 [ 0, %entry ], [ %len.next, %loop ]
  %text = phi ptr [ %buf0, %entry ], [ %text.next, %loop ]
  %len.next = add i64 %len, 1
  %need = add i64 %len.next, 2
  %text.next = call ptr @realloc(ptr %text, i64 %need)
  %cat = call ptr @strcat(ptr %text.next, ptr @xstr)
  %i.next = add i64 %i, 1
  %c = icmp slt i64 %i.next, 750000
  br i1 %c, label %loop, label %end

end:                                              ; preds = %loop
  call void @t_report()
  %n = call i64 @strlen(ptr %text.next)
  %pr = call i32 (ptr, ...) @printf(ptr @ofmt, i64 %n)
  call void @free(ptr %text.next)
  ret i32 0
}
