;; task 01 branches — expected output: 33333334 13333333 7619048 45714285
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 01_branches.rkt
;; note: Racket.exe is the console launcher. GRacket.exe is the GUI-subsystem build of
;;       the same runtime and prints nothing to a console.
;; note: #lang racket/base rather than #lang racket, which is the documented way to get a
;;       faster start-up; every form these tasks need is in racket/base.
;; note: the loops are `for`/`for/fold` accumulators or named `let` loops, not `set!` on a
;;       loop local. Racket's own performance chapter measures `set!` in a hot loop as
;;       allocating a fresh location per iteration, so mutation of a loop variable is the
;;       slow way to write it here and the accumulator is the fast way.
#lang racket/base

;; Self-timing: current-inexact-milliseconds is Racket's monotonic wall-clock reading, in
;; milliseconds as an inexact real. The start is the first form the module body runs and the
;; stop is taken immediately before the answer is printed, so the bracketed region is the
;; task's own work and nothing else. eprintf writes to (current-error-port), so stdout is
;; unchanged.
(define timer-start (current-inexact-milliseconds))
(define (elapsed-ms) (- (current-inexact-milliseconds) timer-start))

;; Four counters over a hundred million iterations, the same nested test as every other row.
;; for/fold carries all four as accumulators; no mutation anywhere in the loop.
(define-values (a b c d)
  (for/fold ([a 0] [b 0] [c 0] [d 0]) ([i (in-range 100000000)])
    (cond [(zero? (modulo i 3)) (values (add1 a) b c d)]
          [(zero? (modulo i 5)) (values a (add1 b) c d)]
          [(zero? (modulo i 7)) (values a b (add1 c) d)]
          [else (values a b c (add1 d))])))

(eprintf "TIME_MS=~a\n" (elapsed-ms))
(printf "~a ~a ~a ~a\n" a b c d)
