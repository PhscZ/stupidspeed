;; task 15 file_write — expected output: 52428800
;; build: none (wasmtime parses the .wat source directly)
;; run: wasmtime.exe run --dir=. 15_file_write.wat   (out.bin lands in the dir)
;; note: this module is written by hand in WebAssembly text with no compiler in
;;       the toolchain; the .wat is the source and the runnable artifact.
;; note: no libc, so the file is created and truncated with WASI path_open and
;;       written with fd_write: one megabyte at a time, fifty times, the same
;;       buffered shape as the C row. A syscall per byte would measure the kernel
;;       and nothing else, which is why the buffer is a whole megabyte.
;; note: fd_sync stands in for the C row's fflush plus fsync — the point of the
;;       task is that the data really reaches the disk, not the buffer.
;; note: layout — the path string at 100, the file iovec at 200, the opened fd
;;       at 300, the byte count at 400, the 1 MiB buffer at 65536, the stdout
;;       iovec at 64 and the line buffer at 4096.

(module
  (import "wasi_snapshot_preview1" "fd_write"
    (func $fd_write (param i32 i32 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "path_open"
    (func $path_open (param i32 i32 i32 i32 i32 i64 i64 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "fd_sync"
    (func $fd_sync (param i32) (result i32)))
  (import "wasi_snapshot_preview1" "fd_close"
    (func $fd_close (param i32) (result i32)))
  (memory (export "memory") 64)
  (data (i32.const 100) "out.bin")

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
    (local $i i32) (local $err i32) (local $fd i32)
    (local $written i64) (local $rep i32)

    ;; the 1 MiB buffer is bytes 0..255 over and over
    (block $built
      (loop $build
        (br_if $built (i32.ge_u (local.get $i) (i32.const 1048576)))
        (i32.store8 (i32.add (i32.const 65536) (local.get $i))
                    (i32.and (local.get $i) (i32.const 255)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $build)))

    ;; path_open(preopen=3, dirflags=0, path=100, len=7,
    ;;           oflags=O_CREAT|O_TRUNC(9),
    ;;           rights_base=RIGHT_FD_WRITE|RIGHT_FD_SYNC(320),
    ;;           rights_inh=0, fdflags=0, out=300)
    (local.set $err
      (call $path_open (i32.const 3) (i32.const 0) (i32.const 100) (i32.const 7)
                       (i32.const 9) (i64.const 320) (i64.const 0) (i32.const 0)
                       (i32.const 300)))
    (local.set $fd (i32.load (i32.const 300)))

    (i32.store (i32.const 200) (i32.const 65536))
    (i32.store (i32.const 204) (i32.const 1048576))
    (block $written
      (loop $write
        (br_if $written (i32.ge_u (local.get $rep) (i32.const 50)))
        (local.set $err
          (call $fd_write (local.get $fd) (i32.const 200) (i32.const 1)
                          (i32.const 400)))
        (local.set $written
          (i64.add (local.get $written)
                   (i64.extend_i32_u (i32.load (i32.const 400)))))
        (local.set $rep (i32.add (local.get $rep) (i32.const 1)))
        (br $write)))

    (drop (call $fd_sync (local.get $fd)))
    (drop (call $fd_close (local.get $fd)))

    (call $puti (local.get $written))
    (call $putc (i32.const 10))
    (call $flush)))
