;; task 05 alloc_churn — expected output: 1274991808
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 05_alloc_churn.rkt
;; note: Racket.exe is the console launcher. GRacket.exe is the GUI-subsystem build of
;;       the same runtime and prints nothing to a console.
;; note: #lang racket/base rather than #lang racket, which is the documented way to get a
;;       faster start-up; every form these tasks need is in racket/base.
;; note: the loops are `for`/`for/fold` accumulators or named `let` loops, not `set!` on a
;;       loop local. Racket's own performance chapter measures `set!` in a hot loop as
;;       allocating a fresh location per iteration, so mutation of a loop variable is the
;;       slow way to write it here and the accumulator is the fast way.
#lang racket/base

;; Ten million 64-byte byte strings, each stored into one of 256 slots so the buffer it
;; replaces becomes garbage -- the same reachability line the C and Java rows draw. The total
;; adds v, the value written, exactly as the Java row does.
(define slots (make-vector 256 #f))

(define total
  (for/fold ([total 0]) ([i (in-range 10000000)])
    (define v (modulo i 256))
    (define buf (make-bytes 64))
    (bytes-set! buf 0 v)
    (vector-set! slots v buf)
    (+ total v)))

(displayln total)
