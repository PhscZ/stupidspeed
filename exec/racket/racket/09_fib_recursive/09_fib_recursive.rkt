;; task 09 fib_recursive — expected output: 102334155
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 09_fib_recursive.rkt
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

;; Naive fib(40): about 331 million calls, so this measures the call path itself rather than
;; any arithmetic. A plain self-recursive function -- each level is a real call.
(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

;; The answer is computed before the timer is read: fib(40) is the whole task, so leaving the
;; call inside the output form would put all of the work outside the bracketed region.
(define answer (fib 40))
(eprintf "TIME_MS=~a\n" (elapsed-ms))
(displayln answer)
