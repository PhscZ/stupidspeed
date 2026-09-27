;; task 08 average — expected output: 0.498046875
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 08_average.rkt
;; note: Racket.exe is the console launcher. GRacket.exe is the GUI-subsystem build of
;;       the same runtime and prints nothing to a console.
;; note: #lang racket/base rather than #lang racket, which is the documented way to get a
;;       faster start-up; every form these tasks need is in racket/base.
;; note: the loops are `for`/`for/fold` accumulators or named `let` loops, not `set!` on a
;;       loop local. Racket's own performance chapter measures `set!` in a hot loop as
;;       allocating a fresh location per iteration, so mutation of a loop variable is the
;;       slow way to write it here and the accumulator is the fast way.
#lang racket/base

;; A hundred million readings, each a multiple of 1/256, accumulated as an inexact real. The
;; total is far below 2^53, so the sum is exact and the digits do not depend on the order of
;; addition. number->string is what keeps the output to the one expected line.
(define total
  (for/fold ([total 0.0]) ([i (in-range 100000000)])
    (+ total (/ (exact->inexact (modulo i 256)) 256.0))))

(displayln (number->string (/ total 100000000.0)))
