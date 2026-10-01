;; task 01 branches — expected output: 33333334 13333333 7619048 45714285
;; build: none (wasmtime parses the .wat source directly)
;; run: wasmtime.exe run 01_branches.wat
;; note: this module is written by hand in WebAssembly text with no compiler in
;;       the toolchain; the .wat is the source and the runnable artifact.
;; note: the four counters are printed one at a time with single spaces between
;;       them, so the line matches the C reference byte for byte. The C printf
;;       with four %lld arguments would pad nothing here either, but a single
;;       "%lld %lld %lld %lld" is exactly this.

(module
  (import "wasi_snapshot_preview1" "fd_write"
    (func $fd_write (param i32 i32 i32 i32) (result i32)))
  (memory (export "memory") 4)

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

  ;; ---- the task: one if/else chain over i % 3, 5 and 7 --------------------
  (func (export "_start")
    (local $i i64) (local $a i64) (local $b i64) (local $c i64) (local $d i64)
    (block $done
      (loop $loop
        (br_if $done (i64.ge_s (local.get $i) (i64.const 100000000)))
        (if (i64.eqz (i64.rem_s (local.get $i) (i64.const 3)))
          (then (local.set $a (i64.add (local.get $a) (i64.const 1))))
          (else
            (if (i64.eqz (i64.rem_s (local.get $i) (i64.const 5)))
              (then (local.set $b (i64.add (local.get $b) (i64.const 1))))
              (else
                (if (i64.eqz (i64.rem_s (local.get $i) (i64.const 7)))
                  (then (local.set $c (i64.add (local.get $c) (i64.const 1))))
                  (else (local.set $d (i64.add (local.get $d) (i64.const 1)))))))))
        (local.set $i (i64.add (local.get $i) (i64.const 1)))
        (br $loop)))
    (call $puti (local.get $a)) (call $putc (i32.const 32))
    (call $puti (local.get $b)) (call $putc (i32.const 32))
    (call $puti (local.get $c)) (call $putc (i32.const 32))
    (call $puti (local.get $d)) (call $putc (i32.const 10))
    (call $flush)))
