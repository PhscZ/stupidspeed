;; task 05 alloc_churn — expected output: 1274991808
;; build: none (wasmtime parses the .wat source directly)
;; run: wasmtime.exe run 05_alloc_churn.wat
;; note: this module is written by hand in WebAssembly text with no compiler in
;;       the toolchain; the .wat is the source and the runnable artifact.
;; note: WebAssembly has no malloc, so the ten million 64-byte allocations are
;;       served by a hand-written free-list allocator over a fixed arena, which
;;       is the same work the C row's malloc/free does: pop a block off the free
;;       list, push the replaced one back. The slots array is what keeps each
;;       buffer reachable, exactly as in the C row, so nothing here is dead code
;;       the optimiser could drop.
;; note: layout — slots[256] at 8192, free-list head at 9216, bump pointer at
;;       9220, arena of 4096 blocks of 64 bytes at 65536.

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

  ;; ---- a 64-byte free-list allocator --------------------------------------
  ;; a free block stores the next free block address in its first 4 bytes.
  (func $alloc (result i32)
    (local $b i32)
    (local.set $b (i32.load (i32.const 9216)))          ;; free-list head
    (if (result i32) (local.get $b)
      (then
        (i32.store (i32.const 9216) (i32.load (local.get $b)))
        (local.get $b))
      (else
        (local.set $b (i32.load (i32.const 9220)))      ;; bump pointer
        (i32.store (i32.const 9220) (i32.add (local.get $b) (i32.const 64)))
        (local.get $b))))

  (func $release (param $b i32)
    (if (i32.ne (local.get $b) (i32.const 0))          ;; free(NULL) is a no-op
      (then
        (i32.store (local.get $b) (i32.load (i32.const 9216)))
        (i32.store (i32.const 9216) (local.get $b)))))

  ;; ---- the task -----------------------------------------------------------
  (func (export "_start")
    (local $i i64) (local $total i64) (local $buf i32) (local $slot i32)
    (i32.store (i32.const 9220) (i32.const 65536))
    (block $done
      (loop $loop
        (br_if $done (i64.ge_s (local.get $i) (i64.const 10000000)))
        (local.set $buf (call $alloc))
        (i32.store8 (local.get $buf)
                    (i32.wrap_i64 (i64.rem_u (local.get $i) (i64.const 256))))
        (local.set $total
          (i64.add (local.get $total)
                   (i64.extend_i32_u (i32.load8_u (local.get $buf)))))
        (local.set $slot
          (i32.wrap_i64 (i64.rem_u (local.get $i) (i64.const 256))))
        ;; the buffer this slot replaces is released here
        (call $release (i32.load (i32.add (i32.const 8192)
                                          (i32.mul (local.get $slot) (i32.const 4)))))
        (i32.store (i32.add (i32.const 8192) (i32.mul (local.get $slot) (i32.const 4)))
                   (local.get $buf))
        (local.set $i (i64.add (local.get $i) (i64.const 1)))
        (br $loop)))
    (local.set $slot (i32.const 0))
    (block $freed
      (loop $freeloop
        (br_if $freed (i32.ge_u (local.get $slot) (i32.const 256)))
        (call $release (i32.load (i32.add (i32.const 8192)
                                          (i32.mul (local.get $slot) (i32.const 4)))))
        (local.set $slot (i32.add (local.get $slot) (i32.const 1)))
        (br $freeloop)))
    (call $puti (local.get $total))
    (call $putc (i32.const 10))
    (call $flush)))
