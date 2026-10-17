; task 01 branches — expected output: 33333334 13333333 7619048 45714285
; build: llc -O2 -filetype=obj -o prog.obj 01_branches.ll
;        clang -O2 -fuse-ld=lld prog.obj -o prog.exe
; run: prog.exe
; note: this file is hand-written LLVM IR. The .ll text is the compiler input and
;       the source; no C was compiled to produce it.
; note: the row's standing choice, identical in all fifteen files: the C runtime
;       for formatted output, allocation and file I/O, and kernel32 directly only
;       for the clock (QueryPerformanceCounter) and, in task 11, for threads
;       (CreateThread/WaitForSingleObject/CloseHandle). This file uses libc printf,
;       fprintf; kernel32 QueryPerformanceFrequency, QueryPerformanceCounter.
; note: the four counters are i64 and printed with one "%lld %lld %lld %lld" so
;       the line matches the C reference byte for byte.

target triple = "x86_64-pc-windows-msvc"

@ofmt = private unnamed_addr constant [21 x i8] c"%lld %lld %lld %lld\0A\00"
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

loop:                                             ; preds = %cont, %entry
  %i = phi i64 [ 0, %entry ], [ %i.next, %cont ]
  %a = phi i64 [ 0, %entry ], [ %a.next, %cont ]
  %b = phi i64 [ 0, %entry ], [ %b.next, %cont ]
  %c = phi i64 [ 0, %entry ], [ %c.next, %cont ]
  %d = phi i64 [ 0, %entry ], [ %d.next, %cont ]
  %cond = icmp slt i64 %i, 100000000
  br i1 %cond, label %body, label %end

body:                                             ; preds = %loop
  %m3 = srem i64 %i, 3
  %is3 = icmp eq i64 %m3, 0
  br i1 %is3, label %case_a, label %test5

test5:                                            ; preds = %body
  %m5 = srem i64 %i, 5
  %is5 = icmp eq i64 %m5, 0
  br i1 %is5, label %case_b, label %test7

test7:                                            ; preds = %test5
  %m7 = srem i64 %i, 7
  %is7 = icmp eq i64 %m7, 0
  br i1 %is7, label %case_c, label %case_d

case_a:                                           ; preds = %body
  %a.1 = add i64 %a, 1
  br label %cont

case_b:                                           ; preds = %test5
  %b.1 = add i64 %b, 1
  br label %cont

case_c:                                           ; preds = %test7
  %c.1 = add i64 %c, 1
  br label %cont

case_d:                                           ; preds = %test7
  %d.1 = add i64 %d, 1
  br label %cont

cont:                                             ; preds = %case_d, %case_c, %case_b, %case_a
  %a.next = phi i64 [ %a.1, %case_a ], [ %a, %case_b ], [ %a, %case_c ], [ %a, %case_d ]
  %b.next = phi i64 [ %b, %case_a ], [ %b.1, %case_b ], [ %b, %case_c ], [ %b, %case_d ]
  %c.next = phi i64 [ %c, %case_a ], [ %c, %case_b ], [ %c.1, %case_c ], [ %c, %case_d ]
  %d.next = phi i64 [ %d, %case_a ], [ %d, %case_b ], [ %d, %case_c ], [ %d.1, %case_d ]
  %i.next = add i64 %i, 1
  br label %loop

end:                                              ; preds = %loop
  call void @t_report()
  %p = call i32 (ptr, ...) @printf(ptr @ofmt, i64 %a, i64 %b, i64 %c, i64 %d)
  ret i32 0
}
