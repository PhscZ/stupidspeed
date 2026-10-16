; task 02 switch_case — expected output: 8748000081000000
; build: llc -O2 -filetype=obj -o prog.obj 02_switch_case.ll
;        clang -O2 -fuse-ld=lld prog.obj -o prog.exe
; run: prog.exe
; note: this file is hand-written LLVM IR. The .ll text is the compiler input and
;       the source; no C was compiled to produce it.
; note: the row's standing choice, identical in all fifteen files: the C runtime
;       for formatted output, allocation and file I/O, and kernel32 directly only
;       for the clock (QueryPerformanceCounter) and, in task 11, for threads
;       (CreateThread/WaitForSingleObject/CloseHandle). This file uses libc printf,
;       fprintf; kernel32 QueryPerformanceFrequency, QueryPerformanceCounter.
; note: the dispatch is the LLVM `switch` instruction on the i64 remainder i % 4,
;       which llc lowers to a jump table; the four arms feed one phi node.

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

define i32 @main() {
entry:
  call void @t_start()
  br label %loop

loop:                                             ; preds = %cont, %entry
  %i = phi i64 [ 0, %entry ], [ %i.next, %cont ]
  %acc = phi i64 [ 0, %entry ], [ %acc.next, %cont ]
  %cond = icmp slt i64 %i, 108000000
  br i1 %cond, label %body, label %end

body:                                             ; preds = %loop
  %r = srem i64 %i, 4
  switch i64 %r, label %cont [
    i64 0, label %case0
    i64 1, label %case1
    i64 2, label %case2
    i64 3, label %case3
  ]

case0:                                            ; preds = %body
  %a0 = add i64 %acc, 1
  br label %cont

case1:                                            ; preds = %body
  %a1 = add i64 %acc, %i
  br label %cont

case2:                                            ; preds = %body
  %t2 = mul i64 %i, 2
  %a2 = add i64 %acc, %t2
  br label %cont

case3:                                            ; preds = %body
  %t3 = mul i64 %i, 3
  %a3 = add i64 %acc, %t3
  br label %cont

cont:                                             ; preds = %case3, %case2, %case1, %case0, %body
  %acc.next = phi i64 [ %acc, %body ], [ %a0, %case0 ], [ %a1, %case1 ], [ %a2, %case2 ], [ %a3, %case3 ]
  %i.next = add i64 %i, 1
  br label %loop

end:                                              ; preds = %loop
  call void @t_report()
  %p = call i32 (ptr, ...) @printf(ptr @ofmt, i64 %acc)
  ret i32 0
}
