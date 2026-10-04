;; task 14 file_read — expected output: 2389704704
;; build: none (wasmtime parses the .wat source directly)
;; run: wasmtime.exe run --dir=. 14_file_read.wat   (run where data.bin lives)
;; note: this module is written by hand in WebAssembly text with no compiler in
;;       the toolchain; the .wat is the source and the runnable artifact.
;; note: no libc, so the file is opened with WASI path_open and read with
;;       fd_read, one megabyte at a time into a buffer at byte 65536, and every
;;       byte is added as it arrives. The 50 MiB file is the bytes 0..255 over
;;       and over, so the raw total is 6684672000 and the row prints it modulo
;;       2^32, exactly as the C row does.
;; note: layout — the path string at 100, the iovec at 200, the opened fd at
;;       300, the byte count at 400, the read buffer at 65536, the line buffer
;;       at 4096.

(module
  (import "wasi_snapshot_preview1" "fd_write"
    (func $fd_write (param i32 i32 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "clock_time_get"
    (func $clock_time_get (param i32 i64 i32) (result i32)))
  (import "wasi_snapshot_preview1" "path_open"
    (func $path_open (param i32 i32 i32 i32 i32 i64 i64 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "fd_read"
    (func $fd_read (param i32 i32 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "fd_close"
    (func $fd_close (param i32) (result i32)))
  (memory (export "memory") 64)
  (data (i32.const 100) "data.bin")

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
    (local $err i32) (local $fd i32) (local $n i32)
    (local $total i64) (local $i i32) (local $b i32)
    (call $ss_start)

    (i32.store (i32.const 200) (i32.const 65536))      ;; iovec -> read buffer
    (i32.store (i32.const 204) (i32.const 1048576))    ;; 1 MiB

    ;; path_open(preopen=3, dirflags=0, path=100, len=8, oflags=0,
    ;;           rights_base=RIGHT_FD_READ(2), rights_inh=0, fdflags=0, out=300)
    (local.set $err
      (call $path_open (i32.const 3) (i32.const 0) (i32.const 100) (i32.const 8)
                       (i32.const 0) (i64.const 2) (i64.const 0) (i32.const 0)
                       (i32.const 300)))
    (local.set $fd (i32.load (i32.const 300)))

    (block $done
      (loop $loop
        (local.set $err
          (call $fd_read (local.get $fd) (i32.const 200) (i32.const 1)
                         (i32.const 400)))
        (local.set $n (i32.load (i32.const 400)))
        (br_if $done (i32.eqz (local.get $n)))
        (local.set $i (i32.const 0))
        (block $summed
          (loop $sum
            (br_if $summed (i32.ge_u (local.get $i) (local.get $n)))
            (local.set $b
              (i32.load8_u (i32.add (i32.const 65536) (local.get $i))))
            (local.set $total
              (i64.add (local.get $total) (i64.extend_i32_u (local.get $b))))
            (local.set $i (i32.add (local.get $i) (i32.const 1)))
            (br $sum)))
        (br $loop)))

    (drop (call $fd_close (local.get $fd)))
    (call $puti (i64.and (local.get $total) (i64.const 4294967295)))
    (call $putc (i32.const 10))
    (call $ss_stop)
    (call $flush)
    (call $ss_report)))
