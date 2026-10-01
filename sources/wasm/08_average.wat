;; task 08 average — expected output: 0.498046875
;; build: none (wasmtime parses the .wat source directly)
;; run: wasmtime.exe run 08_average.wat
;; note: this module is written by hand in WebAssembly text with no compiler in
;;       the toolchain; the .wat is the source and the runnable artifact.
;; note: every reading is a multiple of 1/256 and the total stays under 2^53, so
;;       the sum is exact and the order of the additions does not matter — that
;;       is the property the task is built on, and f64 here behaves as it does
;;       in the C row.
;; note: the printed form is %.9f, so the value is split into its integer part
;;       and a nine-digit fraction. The C row's printf rounds; the fraction is
;;       exact here, so a half-ulp nudge before the truncation is enough to make
;;       the two agree.

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

  ;; ---- %.9f ---------------------------------------------------------------
  (func $putf9 (param $v f64)
    (local $ip i64) (local $fr i64) (local $t i64)
    (local.set $ip (i64.trunc_f64_s (local.get $v)))
    (local.set $fr
      (i64.trunc_f64_s
        (f64.add
          (f64.mul (f64.sub (local.get $v) (f64.convert_i64_s (local.get $ip)))
                   (f64.const 1000000000))
          (f64.const 0.5))))
    (call $puti (local.get $ip))
    (call $putc (i32.const 46))
    (local.set $t (i64.const 100000000))
    (block $done
      (loop $l
        (br_if $done (i64.eqz (local.get $t)))
        (call $putc (i32.add (i32.const 48)
                            (i32.wrap_i64 (i64.div_u (local.get $fr) (local.get $t)))))
        (local.set $fr (i64.rem_u (local.get $fr) (local.get $t)))
        (local.set $t (i64.div_u (local.get $t) (i64.const 10)))
        (br $l))))

  ;; ---- the task -----------------------------------------------------------
  (func (export "_start")
    (local $i i64) (local $total f64)
    (block $done
      (loop $loop
        (br_if $done (i64.ge_s (local.get $i) (i64.const 100000000)))
        (local.set $total
          (f64.add (local.get $total)
                   (f64.div (f64.convert_i64_u
                              (i64.rem_u (local.get $i) (i64.const 256)))
                            (f64.const 256))))
        (local.set $i (i64.add (local.get $i) (i64.const 1)))
        (br $loop)))
    (call $putf9 (f64.div (local.get $total) (f64.const 100000000)))
    (call $putc (i32.const 10))
    (call $flush)))
