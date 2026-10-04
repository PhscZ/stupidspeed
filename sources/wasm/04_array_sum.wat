;; task 04 array_sum — expected output: 499999500000
;; build: none (wasmtime parses the .wat source directly)
;; run: wasmtime.exe run 04_array_sum.wat
;; note: this module is written by hand in WebAssembly text with no compiler in
;;       the toolchain; the .wat is the source and the runnable artifact.
;; note: the array is int64_t in the C row, so the elements are 8 bytes here
;;       too: a million of them start at byte 65536 and run to 8.06 MB, which
;;       is why the module asks for 160 pages.

(module
  (import "wasi_snapshot_preview1" "fd_write"
    (func $fd_write (param i32 i32 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "clock_time_get"
    (func $clock_time_get (param i32 i64 i32) (result i32)))
  (memory (export "memory") 160)

  ;; ---- stdout: decimal digits are built backwards in 0..32, copied into the
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
    (local.set $p (i32.const 32))
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
    (call $emit (local.get $p) (i32.sub (i32.const 32) (local.get $p))))

  (func $flush
    (i32.store (i32.const 64) (i32.const 4096))
    (i32.store (i32.const 68) (i32.sub (global.get $out) (i32.const 4096)))
    (drop (call $fd_write (i32.const 1) (i32.const 64) (i32.const 1) (i32.const 72))))

  ;; ---- the task: fill a million i64s, then read them back ----------------
  ;; array base = 65536, element i at 65536 + 8*i
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
    (local $i i64) (local $total i64)
    (call $ss_start)
    (block $filled
      (loop $fill
        (br_if $filled (i64.ge_s (local.get $i) (i64.const 1000000)))
        (i64.store (i32.add (i32.const 65536)
                           (i32.wrap_i64 (i64.mul (local.get $i) (i64.const 8))))
                   (local.get $i))
        (local.set $i (i64.add (local.get $i) (i64.const 1)))
        (br $fill)))
    (local.set $i (i64.const 0))
    (block $summed
      (loop $sum
        (br_if $summed (i64.ge_s (local.get $i) (i64.const 1000000)))
        (local.set $total
          (i64.add (local.get $total)
                   (i64.load (i32.add (i32.const 65536)
                                     (i32.wrap_i64 (i64.mul (local.get $i) (i64.const 8)))))))
        (local.set $i (i64.add (local.get $i) (i64.const 1)))
        (br $sum)))
    (call $puti (local.get $total))
    (call $putc (i32.const 10))
    (call $ss_stop)
    (call $flush)
    (call $ss_report)))
