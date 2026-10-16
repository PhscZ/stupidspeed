; task 11 parallel_sum — expected output: 8748000081000000
; build: llc -O2 -filetype=obj -o prog.obj 11_parallel_sum.ll
;        clang -O2 -fuse-ld=lld prog.obj -o prog.exe
; run: prog.exe
; note: this file is hand-written LLVM IR. The .ll text is the compiler input and
;       the source; no C was compiled to produce it.
; note: LLVM IR has no library at all, let alone a thread library, so the four
;       workers are real OS threads made with kernel32 CreateThread and joined
;       with WaitForSingleObject — the same route the C row takes on Windows and
;       the same route the Assembly row takes. Each worker owns a fixed quarter,
;       [t * 27000000, (t + 1) * 27000000), so the checksum does not depend on how
;       the OS schedules them. The worker index travels in a four-element global
;       array rather than four literal calls, as in the C reference.
; note: the row's standing choice, identical in all fifteen files: the C runtime
;       for formatted output, allocation and file I/O, and kernel32 directly only
;       for the clock (QueryPerformanceCounter) and, in task 11, for threads
;       (CreateThread/WaitForSingleObject/CloseHandle). This file uses libc printf;
;       kernel32 QueryPerformanceFrequency, QueryPerformanceCounter, CreateThread,
;       WaitForSingleObject, CloseHandle.

target triple = "x86_64-pc-windows-msvc"

%Job = type { i64, i64 }

@jobs = internal global [4 x %Job] zeroinitializer
@threads = internal global [4 x ptr] zeroinitializer
@ofmt = private unnamed_addr constant [6 x i8] c"%lld\0A\00"
@efmt = private unnamed_addr constant [21 x i8] c"TIME_MS=%lld.%03lld\0A\00"
@qpf = internal global i64 0
@qpc = internal global i64 0

declare i32 @printf(ptr, ...)
declare i32 @fprintf(ptr, ptr, ...)
declare ptr @__acrt_iob_func(i32)
declare i32 @QueryPerformanceFrequency(ptr)
declare i32 @QueryPerformanceCounter(ptr)
declare ptr @CreateThread(ptr, i64, ptr, ptr, i32, ptr)
declare i32 @WaitForSingleObject(ptr, i32)
declare i32 @CloseHandle(ptr)

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

; ---- the work: task 02's switch over one quarter ---------------------------
define internal i64 @work_range(i64 %t) {
entry:
  %lo = mul i64 %t, 27000000
  %hi = add i64 %lo, 27000000
  br label %loop

loop:                                             ; preds = %cont, %entry
  %i = phi i64 [ %lo, %entry ], [ %i.next, %cont ]
  %acc = phi i64 [ 0, %entry ], [ %acc.next, %cont ]
  %cond = icmp slt i64 %i, %hi
  br i1 %cond, label %body, label %end

body:                                             ; preds = %loop
  %m = srem i64 %i, 4
  switch i64 %m, label %case3 [
    i64 0, label %case0
    i64 1, label %case1
    i64 2, label %case2
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

cont:                                             ; preds = %case3, %case2, %case1, %case0
  %acc.next = phi i64 [ %a0, %case0 ], [ %a1, %case1 ], [ %a2, %case2 ], [ %a3, %case3 ]
  %i.next = add i64 %i, 1
  br label %loop

end:                                              ; preds = %loop
  ret i64 %acc
}

; ---- the thread entry point: DWORD WINAPI worker(LPVOID) --------------------
define internal i32 @worker(ptr %p) {
entry:
  %tp = getelementptr %Job, ptr %p, i32 0, i32 0
  %t = load i64, ptr %tp
  %r = call i64 @work_range(i64 %t)
  %ap = getelementptr %Job, ptr %p, i32 0, i32 1
  store i64 %r, ptr %ap
  ret i32 0
}

define i32 @main() {
entry:
  call void @t_start()
  br label %spawn

spawn:                                            ; preds = %spawn.next, %entry
  %t = phi i64 [ 0, %entry ], [ %t1, %spawn.next ]
  %sc = icmp slt i64 %t, 4
  br i1 %sc, label %spawn.body, label %wait

spawn.body:                                       ; preds = %spawn
  %jt = getelementptr [4 x %Job], ptr @jobs, i64 0, i64 %t, i32 0
  store i64 %t, ptr %jt
  %ja = getelementptr [4 x %Job], ptr @jobs, i64 0, i64 %t, i32 1
  store i64 0, ptr %ja
  %jp = getelementptr [4 x %Job], ptr @jobs, i64 0, i64 %t
  %h = call ptr @CreateThread(ptr null, i64 0, ptr @worker, ptr %jp, i32 0, ptr null)
  %tp = getelementptr [4 x ptr], ptr @threads, i64 0, i64 %t
  store ptr %h, ptr %tp
  br label %spawn.next

spawn.next:                                       ; preds = %spawn.body
  %t1 = add i64 %t, 1
  br label %spawn

wait:                                             ; preds = %wait.next, %spawn
  %w = phi i64 [ 0, %spawn ], [ %w1, %wait.next ]
  %wc = icmp slt i64 %w, 4
  br i1 %wc, label %wait.body, label %total

wait.body:                                        ; preds = %wait
  %tp2 = getelementptr [4 x ptr], ptr @threads, i64 0, i64 %w
  %hh = load ptr, ptr %tp2
  %r = call i32 @WaitForSingleObject(ptr %hh, i32 -1)   ; INFINITE
  %cr = call i32 @CloseHandle(ptr %hh)
  br label %wait.next

wait.next:                                        ; preds = %wait.body
  %w1 = add i64 %w, 1
  br label %wait

total:                                            ; preds = %wait
  br label %sumloop

sumloop:                                          ; preds = %sumloop.next, %total
  %u = phi i64 [ 0, %total ], [ %u1, %sumloop.next ]
  %s = phi i64 [ 0, %total ], [ %s.1, %sumloop.next ]
  %uc = icmp slt i64 %u, 4
  br i1 %uc, label %sumloop.body, label %done

sumloop.body:                                     ; preds = %sumloop
  %ap = getelementptr [4 x %Job], ptr @jobs, i64 0, i64 %u, i32 1
  %av = load i64, ptr %ap
  %s.1 = add i64 %s, %av
  br label %sumloop.next

sumloop.next:                                     ; preds = %sumloop.body
  %u1 = add i64 %u, 1
  br label %sumloop

done:                                             ; preds = %sumloop
  call void @t_report()
  %p = call i32 (ptr, ...) @printf(ptr @ofmt, i64 %s)
  ret i32 0
}
