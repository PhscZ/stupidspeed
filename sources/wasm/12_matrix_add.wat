;; task 12 matrix_add — expected output: 999000000
;; build: none (wasmtime parses the .wat source directly)
;; run: wasmtime.exe run 12_matrix_add.wat
;; note: this module is written by hand in WebAssembly text with no compiler in
;;       the toolchain; the .wat is the source and the runnable artifact.
;; note: three 1000x1000 arrays of int64_t, as in the C row — eight megabytes
;;       each, so they do not fit in cache and the task measures memory movement
;;       rather than arithmetic.
;; note: layout — A at 65536, B at 8065536, C at 16065536, each 8000000 bytes;
;;       the module asks for 384 pages.

(module
  (import "wasi_snapshot_preview1" "fd_write"
    (func $fd_write (param i32 i32 i32 i32) (result i32)))
  (memory (export "memory") 384)

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

  ;; ---- the task -----------------------------------------------------------
  (func (export "_start")
    (local $i i64) (local $j i64) (local $k i64)
    (local $off i32) (local $total i64)
    ;; build A[i][j] = i + j and B[i][j] = i - j
    (block $built
      (loop $il
        (br_if $built (i64.ge_s (local.get $i) (i64.const 1000)))
        (local.set $j (i64.const 0))
        (block $jdone
          (loop $jl
            (br_if $jdone (i64.ge_s (local.get $j) (i64.const 1000)))
            (local.set $off
              (i32.wrap_i64
                (i64.mul (i64.add (i64.mul (local.get $i) (i64.const 1000))
                                  (local.get $j))
                         (i64.const 8))))
            (i64.store (i32.add (i32.const 65536) (local.get $off))
                       (i64.add (local.get $i) (local.get $j)))
            (i64.store (i32.add (i32.const 8065536) (local.get $off))
                       (i64.sub (local.get $i) (local.get $j)))
            (local.set $j (i64.add (local.get $j) (i64.const 1)))
            (br $jl)))
        (local.set $i (i64.add (local.get $i) (i64.const 1)))
        (br $il)))
    ;; C[k] = A[k] + B[k]
    (local.set $k (i64.const 0))
    (block $added
      (loop $kl
        (br_if $added (i64.ge_s (local.get $k) (i64.const 1000000)))
        (local.set $off (i32.wrap_i64 (i64.mul (local.get $k) (i64.const 8))))
        (i64.store (i32.add (i32.const 16065536) (local.get $off))
                   (i64.add (i64.load (i32.add (i32.const 65536) (local.get $off)))
                            (i64.load (i32.add (i32.const 8065536) (local.get $off)))))
        (local.set $k (i64.add (local.get $k) (i64.const 1)))
        (br $kl)))
    ;; sum of C
    (local.set $k (i64.const 0))
    (block $summed
      (loop $sl
        (br_if $summed (i64.ge_s (local.get $k) (i64.const 1000000)))
        (local.set $total
          (i64.add (local.get $total)
                   (i64.load (i32.add (i32.const 16065536)
                                     (i32.wrap_i64 (i64.mul (local.get $k) (i64.const 8)))))))
        (local.set $k (i64.add (local.get $k) (i64.const 1)))
        (br $sl)))
    (call $puti (local.get $total))
    (call $putc (i32.const 10))
    (call $flush)))
