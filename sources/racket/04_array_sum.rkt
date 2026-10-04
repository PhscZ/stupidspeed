;; task 04 array_sum — expected output: 499999500000
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 04_array_sum.rkt
;; note: Racket.exe is the console launcher. GRacket.exe is the GUI-subsystem build of
;;       the same runtime and prints nothing to a console.
;; note: #lang racket/base rather than #lang racket, which is the documented way to get a
;;       faster start-up; every form these tasks need is in racket/base.
;; note: the loops are `for`/`for/fold` accumulators or named `let` loops, not `set!` on a
;;       loop local. Racket's own performance chapter measures `set!` in a hot loop as
;;       allocating a fresh location per iteration, so mutation of a loop variable is the
;;       slow way to write it here and the accumulator is the fast way.
#lang racket/base
(require racket/fixnum)   ; fxvector, make-fxvector, fxvector-ref/set!

;; Self-timing: current-inexact-milliseconds is Racket's monotonic wall-clock reading, in
;; milliseconds as an inexact real. The start is the first form the module body runs and the
;; stop is taken immediately before the answer is printed, so the bracketed region is the
;; task's own work and nothing else. eprintf writes to (current-error-port), so stdout is
;; unchanged.
(define timer-start (current-inexact-milliseconds))
(define (elapsed-ms) (- (current-inexact-milliseconds) timer-start))

;; A million-element fxvector, filled and then summed in two separate passes, so the fill is
;; not part of the read loop. fxvector holds unboxed fixnums, which is the packed array here.
(define n 1000000)
(define arr (make-fxvector n))

(for ([i (in-range n)])
  (fxvector-set! arr i i))

(define total
  (for/fold ([total 0]) ([i (in-range n)])
    (+ total (fxvector-ref arr i))))

(eprintf "TIME_MS=~a\n" (elapsed-ms))
(displayln total)
