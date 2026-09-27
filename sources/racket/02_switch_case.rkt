;; task 02 switch_case — expected output: 7500000075000000
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 02_switch_case.rkt
;; note: Racket.exe is the console launcher. GRacket.exe is the GUI-subsystem build of
;;       the same runtime and prints nothing to a console.
;; note: #lang racket/base rather than #lang racket, which is the documented way to get a
;;       faster start-up; every form these tasks need is in racket/base.
;; note: the loops are `for`/`for/fold` accumulators or named `let` loops, not `set!` on a
;;       loop local. Racket's own performance chapter measures `set!` in a hot loop as
;;       allocating a fresh location per iteration, so mutation of a loop variable is the
;;       slow way to write it here and the accumulator is the fast way.
#lang racket/base

;; case on (modulo i 4) with a single accumulator. Racket's integers are fixnums here and
;; widen automatically if they have to, so 7500000075000000 is exact with no special type.
(define total
  (for/fold ([acc 0]) ([i (in-range 100000000)])
    (+ acc (case (modulo i 4)
             [(0) 1]
             [(1) i]
             [(2) (* 2 i)]
             [else (* 3 i)]))))

(displayln total)
