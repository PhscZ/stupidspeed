;; task 10 pi — expected output: 4470
;; build: none (wasmtime parses the .wat source directly)
;; run: wasmtime.exe run 10_pi.wat
;; note: this module is written by hand in WebAssembly text with no compiler in
;;       the toolchain; the .wat is the source and the runnable artifact.
;; note: the same Gibbons unbounded spigot as the C row, and the same hand-rolled
;;       integers, because WebAssembly has no big-integer type either. They are
;;       sign-magnitude, little-endian, base 1e9 limbs, with add, subtract,
;;       multiply by a small integer, and a quotient by repeated subtraction —
;;       the spigot only ever asks for one decimal digit at a time.
;; note: the limbs are stored in linear memory as i64, so limb*m + carry fits in
;;       64 bits for every multiplier the spigot uses (the largest is 7k+2, and
;;       k stays below 3400). 1000 digits need at most 1382 limbs, so each big
;;       gets 2048 of them.
;; note: layout — q, r, t, u, v, w at 65536 + 16392*i; limbs at the block base,
;;       the limb count at +16384 and the sign at +16388.

(module
  (import "wasi_snapshot_preview1" "fd_write"
    (func $fd_write (param i32 i32 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "clock_time_get"
    (func $clock_time_get (param i32 i64 i32) (result i32)))
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

  ;; ---- big integers -------------------------------------------------------
  ;; block layout: limb i at base + 8*i, count at base+16384, sign at base+16388
  (global $Q (mut i32) (i32.const 65536))
  (global $R (mut i32) (i32.const 81928))
  (global $T (mut i32) (i32.const 98320))
  (global $U (mut i32) (i32.const 114712))
  (global $V (mut i32) (i32.const 131104))
  (global $W (mut i32) (i32.const 147496))

  (func $nlimb (param $b i32) (result i32)
    (i32.load (i32.add (local.get $b) (i32.const 16384))))

  (func $sgn (param $b i32) (result i32)
    (i32.load (i32.add (local.get $b) (i32.const 16388))))

  (func $setsgn (param $b i32) (param $s i32)
    (i32.store (i32.add (local.get $b) (i32.const 16388)) (local.get $s)))

  (func $limb (param $b i32) (param $i i32) (result i64)
    (i64.load (i32.add (local.get $b) (i32.mul (local.get $i) (i32.const 8)))))

  (func $setlimb (param $b i32) (param $i i32) (param $v i64)
    (i64.store (i32.add (local.get $b) (i32.mul (local.get $i) (i32.const 8)))
               (local.get $v)))

  (func $trim (param $b i32)
    (local $n i32)
    (local.set $n (call $nlimb (local.get $b)))
    (block $done
      (loop $l
        (br_if $done (i32.le_s (local.get $n) (i32.const 0)))
        (br_if $done (i64.ne (call $limb (local.get $b) (i32.sub (local.get $n) (i32.const 1)))
                             (i64.const 0)))
        (local.set $n (i32.sub (local.get $n) (i32.const 1)))
        (br $l)))
    (i32.store (i32.add (local.get $b) (i32.const 16384)) (local.get $n))
    (if (i32.eqz (local.get $n))
      (then (call $setsgn (local.get $b) (i32.const 0)))))

  (func $bset (param $b i32) (param $v i64)
    (local $n i32)
    (call $setsgn (local.get $b) (i32.const 0))
    (block $done
      (loop $l
        (br_if $done (i64.eqz (local.get $v)))
        (call $setlimb (local.get $b) (local.get $n)
                       (i64.rem_u (local.get $v) (i64.const 1000000000)))
        (local.set $n (i32.add (local.get $n) (i32.const 1)))
        (local.set $v (i64.div_u (local.get $v) (i64.const 1000000000)))
        (br $l)))
    (i32.store (i32.add (local.get $b) (i32.const 16384)) (local.get $n)))

  (func $bcopy (param $d i32) (param $s i32)
    (local $i i32) (local $n i32)
    (local.set $n (call $nlimb (local.get $s)))
    (block $done
      (loop $l
        (br_if $done (i32.ge_s (local.get $i) (local.get $n)))
        (call $setlimb (local.get $d) (local.get $i) (call $limb (local.get $s) (local.get $i)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $l)))
    (i32.store (i32.add (local.get $d) (i32.const 16384)) (local.get $n))
    (call $setsgn (local.get $d) (call $sgn (local.get $s))))

  (func $cmpmag (param $a i32) (param $b i32) (result i32)
    (local $na i32) (local $nb i32) (local $i i32) (local $x i64) (local $y i64)
    (local.set $na (call $nlimb (local.get $a)))
    (local.set $nb (call $nlimb (local.get $b)))
    (if (i32.ne (local.get $na) (local.get $nb))
      (then (return (if (result i32) (i32.lt_s (local.get $na) (local.get $nb))
                       (then (i32.const -1)) (else (i32.const 1))))))
    (local.set $i (local.get $na))
    (block $done
      (loop $l
        (br_if $done (i32.le_s (local.get $i) (i32.const 0)))
        (local.set $i (i32.sub (local.get $i) (i32.const 1)))
        (local.set $x (call $limb (local.get $a) (local.get $i)))
        (local.set $y (call $limb (local.get $b) (local.get $i)))
        (if (i64.ne (local.get $x) (local.get $y))
          (then (return (if (result i32) (i64.lt_u (local.get $x) (local.get $y))
                           (then (i32.const -1)) (else (i32.const 1))))))
        (br $l)))
    (i32.const 0))

  (func $bcmp (param $a i32) (param $b i32) (result i32)
    (local $an i32) (local $bn i32) (local $c i32) (local $t i32)
    (local.set $an (call $sgn (local.get $a)))
    (local.set $bn (call $sgn (local.get $b)))
    (if (i32.ne (local.get $an) (local.get $bn))
      (then (return (if (result i32) (local.get $an)
                       (then (i32.const -1)) (else (i32.const 1))))))
    (local.set $c (call $cmpmag (local.get $a) (local.get $b)))
    (if (result i32) (local.get $an)
      (then (i32.sub (i32.const 0) (local.get $c)))
      (else (local.get $c))))

  (func $addmag (param $r i32) (param $a i32) (param $b i32)
    (local $na i32) (local $nb i32) (local $n i32) (local $i i32)
    (local $carry i64) (local $s i64)
    (local.set $na (call $nlimb (local.get $a)))
    (local.set $nb (call $nlimb (local.get $b)))
    (local.set $n (if (result i32) (i32.gt_s (local.get $na) (local.get $nb))
                       (then (local.get $na)) (else (local.get $nb))))
    (block $done
      (loop $l
        (br_if $done (i32.ge_s (local.get $i) (local.get $n)))
        (local.set $s (local.get $carry))
        (if (i32.lt_s (local.get $i) (local.get $na))
          (then (local.set $s (i64.add (local.get $s)
                  (call $limb (local.get $a) (local.get $i))))))
        (if (i32.lt_s (local.get $i) (local.get $nb))
          (then (local.set $s (i64.add (local.get $s)
                  (call $limb (local.get $b) (local.get $i))))))
        (if (i64.ge_u (local.get $s) (i64.const 1000000000))
          (then
            (local.set $s (i64.sub (local.get $s) (i64.const 1000000000)))
            (local.set $carry (i64.const 1)))
          (else (local.set $carry (i64.const 0))))
        (call $setlimb (local.get $r) (local.get $i) (local.get $s))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $l)))
    (call $setlimb (local.get $r) (local.get $n) (local.get $carry))
    (i32.store (i32.add (local.get $r) (i32.const 16384))
               (i32.add (local.get $n) (i32.wrap_i64 (local.get $carry))))
    (call $setsgn (local.get $r) (i32.const 0)))

  (func $submag (param $r i32) (param $a i32) (param $b i32)
    ;; requires |a| >= |b|
    (local $na i32) (local $nb i32) (local $i i32)
    (local $borrow i64) (local $bi i64) (local $ai i64)
    (local.set $na (call $nlimb (local.get $a)))
    (local.set $nb (call $nlimb (local.get $b)))
    (block $done
      (loop $l
        (br_if $done (i32.ge_s (local.get $i) (local.get $na)))
        (local.set $ai (call $limb (local.get $a) (local.get $i)))
        (local.set $bi (local.get $borrow))
        (if (i32.lt_s (local.get $i) (local.get $nb))
          (then (local.set $bi (i64.add (local.get $bi)
                  (call $limb (local.get $b) (local.get $i))))))
        (if (i64.ge_u (local.get $ai) (local.get $bi))
          (then
            (call $setlimb (local.get $r) (local.get $i)
                           (i64.sub (local.get $ai) (local.get $bi)))
            (local.set $borrow (i64.const 0)))
          (else
            (call $setlimb (local.get $r) (local.get $i)
                           (i64.sub (i64.add (local.get $ai) (i64.const 1000000000))
                                    (local.get $bi)))
            (local.set $borrow (i64.const 1))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $l)))
    (i32.store (i32.add (local.get $r) (i32.const 16384)) (local.get $na))
    (call $setsgn (local.get $r) (i32.const 0))
    (call $trim (local.get $r)))

  (func $badd (param $r i32) (param $a i32) (param $b i32)
    (local $an i32) (local $bn i32)
    (local.set $an (call $sgn (local.get $a)))
    (local.set $bn (call $sgn (local.get $b)))
    (if (i32.eq (local.get $an) (local.get $bn))
      (then
        (call $addmag (local.get $r) (local.get $a) (local.get $b))
        (call $setsgn (local.get $r) (local.get $an)))
      (else
        (if (i32.ge_s (call $cmpmag (local.get $a) (local.get $b)) (i32.const 0))
          (then
            (call $submag (local.get $r) (local.get $a) (local.get $b))
            (call $setsgn (local.get $r) (local.get $an)))
          (else
            (call $submag (local.get $r) (local.get $b) (local.get $a))
            (call $setsgn (local.get $r) (local.get $bn))))))
    (call $trim (local.get $r)))

  (func $bsub (param $r i32) (param $a i32) (param $b i32)
    (local $an i32) (local $bn i32) (local $sn i32)
    (local.set $an (call $sgn (local.get $a)))
    (local.set $bn (call $sgn (local.get $b)))
    (if (i32.ne (local.get $an) (local.get $bn))
      (then
        (call $addmag (local.get $r) (local.get $a) (local.get $b))
        (call $setsgn (local.get $r) (local.get $an)))
      (else
        (if (i32.ge_s (call $cmpmag (local.get $a) (local.get $b)) (i32.const 0))
          (then
            (call $submag (local.get $r) (local.get $a) (local.get $b))
            (call $setsgn (local.get $r) (local.get $an)))
          (else
            (local.set $sn (if (result i32) (local.get $an)
                             (then (i32.const 0)) (else (i32.const 1))))
            (call $submag (local.get $r) (local.get $b) (local.get $a))
            (call $setsgn (local.get $r) (local.get $sn))))))
    (call $trim (local.get $r)))

  (func $bmulsmall (param $r i32) (param $a i32) (param $m i64)
    (local $n i32) (local $i i32) (local $carry i64) (local $p i64)
    (local.set $n (call $nlimb (local.get $a)))
    (if (i64.eqz (local.get $m))
      (then
        (i32.store (i32.add (local.get $r) (i32.const 16384)) (i32.const 0))
        (call $setsgn (local.get $r) (i32.const 0))
        (return)))
    (block $done
      (loop $l
        (br_if $done (i32.ge_s (local.get $i) (local.get $n)))
        (local.set $p
          (i64.add (i64.mul (call $limb (local.get $a) (local.get $i)) (local.get $m))
                   (local.get $carry)))
        (call $setlimb (local.get $r) (local.get $i)
                       (i64.rem_u (local.get $p) (i64.const 1000000000)))
        (local.set $carry (i64.div_u (local.get $p) (i64.const 1000000000)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $l)))
    (block $done2
      (loop $l2
        (br_if $done2 (i64.eqz (local.get $carry)))
        (call $setlimb (local.get $r) (local.get $n)
                       (i64.rem_u (local.get $carry) (i64.const 1000000000)))
        (local.set $carry (i64.div_u (local.get $carry) (i64.const 1000000000)))
        (local.set $n (i32.add (local.get $n) (i32.const 1)))
        (br $l2)))
    (i32.store (i32.add (local.get $r) (i32.const 16384)) (local.get $n))
    (call $setsgn (local.get $r) (call $sgn (local.get $a)))
    (call $trim (local.get $r)))

  ;; floor(a / b) for a >= 0, b > 0: count how many times b fits into a.
  (func $bquot (param $a i32) (param $b i32) (param $w i32) (result i64)
    (local $q i64)
    (if (call $sgn (local.get $a)) (then (return (i64.const 0))))
    (if (call $sgn (local.get $b)) (then (return (i64.const 0))))
    (if (i32.eqz (call $nlimb (local.get $b))) (then (return (i64.const 0))))
    (call $bcopy (local.get $w) (local.get $b))
    (block $done
      (loop $l
        (br_if $done (i32.lt_s (call $bcmp (local.get $a) (local.get $w)) (i32.const 0)))
        (local.set $q (i64.add (local.get $q) (i64.const 1)))
        (call $addmag (local.get $w) (local.get $w) (local.get $b))
        (br $l)))
    (local.get $q))

  ;; ---- the task: Gibbons' unbounded spigot, 1000 digits -------------------
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
    (local $produced i64) (local $sum i64)
    (local $k i64) (local $l i64) (local $n i64) (local $next i64)
    (call $ss_start)
    (call $bset (global.get $Q) (i64.const 1))
    (call $bset (global.get $R) (i64.const 0))
    (call $bset (global.get $T) (i64.const 1))
    (local.set $k (i64.const 1))
    (local.set $l (i64.const 3))
    (local.set $n (i64.const 3))
    (block $done
      (loop $loop
        (br_if $done (i64.ge_s (local.get $produced) (i64.const 1000)))
        ;; u = 4q + r
        (call $bmulsmall (global.get $U) (global.get $Q) (i64.const 4))
        (call $badd (global.get $U) (global.get $U) (global.get $R))
        ;; v = (n + 1) t
        (call $bmulsmall (global.get $V) (global.get $T)
                         (i64.add (local.get $n) (i64.const 1)))
        (if (i32.lt_s (call $bcmp (global.get $U) (global.get $V)) (i32.const 0))
          (then
            ;; the digit n is settled
            (local.set $sum (i64.add (local.get $sum) (local.get $n)))
            (local.set $produced (i64.add (local.get $produced) (i64.const 1)))
            ;; u = 10(3q + r)
            (call $bmulsmall (global.get $U) (global.get $Q) (i64.const 3))
            (call $badd (global.get $U) (global.get $U) (global.get $R))
            (call $bmulsmall (global.get $U) (global.get $U) (i64.const 10))
            (local.set $next
              (i64.sub (call $bquot (global.get $U) (global.get $T) (global.get $W))
                       (i64.mul (i64.const 10) (local.get $n))))
            ;; v = n t ; v = r - v ; r = 10 v ; q = 10 q
            (call $bmulsmall (global.get $V) (global.get $T) (local.get $n))
            (call $bsub (global.get $V) (global.get $R) (global.get $V))
            (call $bmulsmall (global.get $R) (global.get $V) (i64.const 10))
            (call $bmulsmall (global.get $Q) (global.get $Q) (i64.const 10))
            (local.set $n (local.get $next)))
          (else
            ;; not settled yet: widen the state by one more term
            (call $bmulsmall (global.get $U) (global.get $Q)
                             (i64.add (i64.mul (i64.const 7) (local.get $k))
                                      (i64.const 2)))
            (call $bmulsmall (global.get $V) (global.get $R) (local.get $l))
            (call $badd (global.get $U) (global.get $U) (global.get $V))
            (call $bmulsmall (global.get $V) (global.get $T) (local.get $l))
            (local.set $next (call $bquot (global.get $U) (global.get $V) (global.get $W)))
            ;; u = (2q + r) l ; r = u
            (call $bmulsmall (global.get $U) (global.get $Q) (i64.const 2))
            (call $badd (global.get $U) (global.get $U) (global.get $R))
            (call $bmulsmall (global.get $U) (global.get $U) (local.get $l))
            (call $bcopy (global.get $R) (global.get $U))
            ;; q = q k ; t = t l
            (call $bmulsmall (global.get $Q) (global.get $Q) (local.get $k))
            (call $bmulsmall (global.get $T) (global.get $T) (local.get $l))
            (local.set $k (i64.add (local.get $k) (i64.const 1)))
            (local.set $l (i64.add (local.get $l) (i64.const 2)))
            (local.set $n (local.get $next))))
        (br $loop)))
    (call $puti (local.get $sum))
    (call $putc (i32.const 10))
    (call $ss_stop)
    (call $flush)
    (call $ss_report)))
