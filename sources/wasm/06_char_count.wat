;; task 06 char_count — expected output: 10000000
;; build: none (wasmtime parses the .wat source directly)
;; run: wasmtime.exe run 06_char_count.wat
;; note: this module is written by hand in WebAssembly text with no compiler in
;;       the toolchain; the .wat is the source and the runnable artifact.
;; note: the whole 100 MB text is materialised before the scan, block by block,
;;       exactly as the C row memcpys "abcdefghij" ten million times — the build
;;       is not folded into the scan, so it is part of the measurement.
;; note: the text starts at byte 65536 and is 100000000 bytes long, so the
;;       module asks for 1600 pages.

(module
  (import "wasi_snapshot_preview1" "fd_write"
    (func $fd_write (param i32 i32 i32 i32) (result i32)))
  (memory (export "memory") 1600)
  (data (i32.const 200) "abcdefghij")

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
  ;; text base = 65536, ten million copies of the ten-byte block
  (func (export "_start")
    (local $i i64) (local $j i32) (local $count i64) (local $p i32)
    (block $built
      (loop $build
        (br_if $built (i64.ge_s (local.get $i) (i64.const 10000000)))
        (local.set $j (i32.const 0))
        (block $block_done
          (loop $block
            (br_if $block_done (i32.ge_u (local.get $j) (i32.const 10)))
            (i32.store8 (i32.add (i32.const 65536)
                                 (i32.add (i32.wrap_i64
                                             (i64.mul (local.get $i) (i64.const 10)))
                                          (local.get $j)))
                        (i32.load8_u (i32.add (i32.const 200) (local.get $j))))
            (local.set $j (i32.add (local.get $j) (i32.const 1)))
            (br $block)))
        (local.set $i (i64.add (local.get $i) (i64.const 1)))
        (br $build)))
    (local.set $i (i64.const 0))
    (block $scanned
      (loop $scan
        (br_if $scanned (i64.ge_s (local.get $i) (i64.const 100000000)))
        (local.set $p (i32.add (i32.const 65536) (i32.wrap_i64 (local.get $i))))
        (if (i32.eq (i32.load8_u (local.get $p)) (i32.const 104))   ;; 'h'
          (then (local.set $count (i64.add (local.get $count) (i64.const 1)))))
        (local.set $i (i64.add (local.get $i) (i64.const 1)))
        (br $scan)))
    (call $puti (local.get $count))
    (call $putc (i32.const 10))
    (call $flush)))
