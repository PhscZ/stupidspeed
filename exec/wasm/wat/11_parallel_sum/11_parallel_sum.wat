;; task 11 parallel_sum — expected output: 7500000075000000
;; build: none (wasmtime parses the .wat source directly)
;; run: wasmtime.exe run -S threads=y -W threads=y -W shared-memory=y 11_parallel_sum.wat
;; note: this module is written by hand in WebAssembly text with no compiler in
;;       the toolchain; the .wat is the source and the runnable artifact.
;; note: four real OS threads come from the wasi-threads API, which is the
;;       language's own threading extension here (WebAssembly itself has none).
;;       The host calls wasi_thread_start(tid, arg) on each new thread; the
;;       parent spawns, then waits on a flag per worker and adds up the four
;;       partial sums.
;; note: the memory is imported from "env" AND exported again. That is the
;;       wasi-libc convention, and it is load-bearing: with a memory that is only
;;       exported, the thread-spawn still returns a valid tid and
;;       wasi_thread_start still runs, but every write it makes lands in a
;;       private memory the parent never sees, so the total silently comes out
;;       as zero.
;; note: each worker owns a fixed range of 25000000, so the split is the same
;;       four quarters of task 02 and the answer is independent of scheduling.
;; note: layout — partial sums at 0,8,16,24 (i64); done flags at 64,68,72,76;
;;       the print scratch at 512 and the line buffer at 4096.

(module
  (import "wasi_snapshot_preview1" "fd_write"
    (func $fd_write (param i32 i32 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "clock_time_get"
    (func $clock_time_get (param i32 i64 i32) (result i32)))
  (import "wasi" "thread-spawn" (func $spawn (param i32) (result i32)))
  (import "env" "memory" (memory 64 64 shared))
  (export "memory" (memory 0))

  ;; ---- stdout: decimal digits are built backwards in 512..0, copied into the
  ;;      line buffer at 4096, and written with one fd_write per line. -------
  (global $out (mut i32) (i32.const 4096))

  (func $putc (param $c i32)
    (i32.store8 (global.get $out) (local.get $c))
    (global.set $out (i32.add (global.get $out) (i32.const 1))))

  (func $emit (param $src i32) (param $len i32)
    (local $i i32)
    (block $done
      (loop $l
        (br_if $done (i32.ge_u (local.get $i) (local.get $len)))
        (i32.store8 (i32.add (global.get $out) (local.get $i))
                    (i32.load8_u (i32.add (local.get $src) (local.get $i))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $l)))
    (global.set $out (i32.add (global.get $out) (local.get $len))))

  (func $puti (param $v i64)
    (local $p i32) (local $neg i32)
    (local.set $p (i32.const 512))
    (if (i64.lt_s (local.get $v) (i64.const 0))
      (then
        (local.set $neg (i32.const 1))
        (local.set $v (i64.sub (i64.const 0) (local.get $v)))))
    (loop $digits
      (local.set $p (i32.sub (local.get $p) (i32.const 1)))
      (i32.store8 (local.get $p)
        (i32.add (i32.const 48)
                 (i32.wrap_i64 (i64.rem_u (local.get $v) (i64.const 10)))))
      (local.set $v (i64.div_u (local.get $v) (i64.const 10)))
      (br_if $digits (i64.ne (local.get $v) (i64.const 0))))
    (if (local.get $neg)
      (then
        (local.set $p (i32.sub (local.get $p) (i32.const 1)))
        (i32.store8 (local.get $p) (i32.const 45))))
    (call $emit (local.get $p) (i32.sub (i32.const 512) (local.get $p))))

  (func $flush
    (i32.store (i32.const 544) (i32.const 4096))
    (i32.store (i32.const 548) (i32.sub (global.get $out) (i32.const 4096)))
    (drop (call $fd_write (i32.const 1) (i32.const 544) (i32.const 1) (i32.const 552))))

  ;; ---- one quarter of task 02's work --------------------------------------
  (func $quarter (param $t i32) (result i64)
    (local $i i64) (local $end i64) (local $acc i64) (local $m i32)
    (local.set $i
      (i64.mul (i64.extend_i32_u (local.get $t)) (i64.const 25000000)))
    (local.set $end
      (i64.mul (i64.extend_i32_u (i32.add (local.get $t) (i32.const 1)))
               (i64.const 25000000)))
    (block $done
      (loop $loop
        (br_if $done (i64.ge_s (local.get $i) (local.get $end)))
        (local.set $m (i32.wrap_i64 (i64.and (local.get $i) (i64.const 3))))
        (block $next
          (block $c3
            (block $c2
              (block $c1
                (block $c0
                  (br_table $c0 $c1 $c2 $c3 (local.get $m)))
                (local.set $acc (i64.add (local.get $acc) (i64.const 1)))
                (br $next))
              (local.set $acc (i64.add (local.get $acc) (local.get $i)))
              (br $next))
            (local.set $acc
              (i64.add (local.get $acc) (i64.mul (local.get $i) (i64.const 2))))
            (br $next))
          (local.set $acc
            (i64.add (local.get $acc) (i64.mul (local.get $i) (i64.const 3)))))
        (local.set $i (i64.add (local.get $i) (i64.const 1)))
        (br $loop)))
    (local.get $acc))

  ;; the host calls this on each new thread
  (func (export "wasi_thread_start") (param $tid i32) (param $arg i32)
    (local $flag i32)
    (i64.atomic.store (i32.mul (local.get $arg) (i32.const 8))
                      (call $quarter (local.get $arg)))
    (local.set $flag
      (i32.add (i32.const 64) (i32.mul (local.get $arg) (i32.const 4))))
    (i32.atomic.store (local.get $flag) (i32.const 1))
    (drop (memory.atomic.notify (local.get $flag) (i32.const 1))))

  ;; ---- the task -----------------------------------------------------------
  ;; ---- self-timing: report TIME_MS on stderr (fd 2); stdout unchanged ------
  (global $t0 (mut i64) (i64.const 0))
  (global $t1 (mut i64) (i64.const 0))

  (func $ss_now (result i64)
    (drop (call $clock_time_get (i32.const 1) (i64.const 1000) (i32.const 2048)))
    (i64.load (i32.const 2048)))

  (func $ss_start
    (global.set $t0 (call $ss_now)))

  (func $ss_stop
    (global.set $t1 (call $ss_now)))

  (func $ss_report
    (local $ms i64)
    (global.set $out (i32.const 4096))   ;; start a fresh line, after $flush
    (local.set $ms
      (i64.div_u (i64.sub (global.get $t1) (global.get $t0)) (i64.const 1000000)))
    (call $putc (i32.const 84))          ;; T
    (call $putc (i32.const 73))          ;; I
    (call $putc (i32.const 77))          ;; M
    (call $putc (i32.const 69))          ;; E
    (call $putc (i32.const 95))          ;; _
    (call $putc (i32.const 77))          ;; M
    (call $putc (i32.const 83))          ;; S
    (call $putc (i32.const 61))          ;; =
    (call $puti (local.get $ms))
    (call $putc (i32.const 10))
    (i32.store (i32.const 2048) (i32.const 4096))
    (i32.store (i32.const 2052) (i32.sub (global.get $out) (i32.const 4096)))
    (drop (call $fd_write (i32.const 2) (i32.const 2048) (i32.const 1)
                          (i32.const 2056))))
  (func (export "_start")
    (local $t i32) (local $total i64) (local $flag i32)
    (call $ss_start)
    (block $spawned
      (loop $sloop
        (br_if $spawned (i32.ge_u (local.get $t) (i32.const 4)))
        (drop (call $spawn (local.get $t)))
        (local.set $t (i32.add (local.get $t) (i32.const 1)))
        (br $sloop)))
    (local.set $t (i32.const 0))
    (block $waited
      (loop $wloop
        (br_if $waited (i32.ge_u (local.get $t) (i32.const 4)))
        (local.set $flag
          (i32.add (i32.const 64) (i32.mul (local.get $t) (i32.const 4))))
        (block $got
          (loop $spin
            (br_if $got
              (i32.eq (i32.atomic.load (local.get $flag)) (i32.const 1)))
            (drop (memory.atomic.wait32 (local.get $flag) (i32.const 0)
                                        (i64.const -1)))
            (br $spin)))
        (local.set $total
          (i64.add (local.get $total)
                   (i64.atomic.load (i32.mul (local.get $t) (i32.const 8)))))
        (local.set $t (i32.add (local.get $t) (i32.const 1)))
        (br $wloop)))
    (call $puti (local.get $total))
    (call $putc (i32.const 10))
    (call $ss_stop)
    (call $flush)
    (call $ss_report)))
