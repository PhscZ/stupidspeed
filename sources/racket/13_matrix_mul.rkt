;; task 13 matrix_mul — expected output: 599995000
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 13_matrix_mul.rkt
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

;; The plain i, j, k triple loop in that order on flat row-major vectors, so the k loop walks a
;; column of B. Reordering would be faster, which is the point.
(define n 500)
(define elems (* n n))
(define a (make-fxvector elems))
(define b (make-fxvector elems))
(define c (make-fxvector elems))

(for ([i (in-range n)])
  (for ([j (in-range n)])
    (define idx (+ (* i n) j))
    (fxvector-set! a idx (modulo (+ i j) 7))
    (fxvector-set! b idx (modulo (* i j) 5))))

(for ([r (in-range n)])
  (for ([col (in-range n)])
    (define sum
      (for/fold ([acc 0]) ([k (in-range n)])
        (+ acc (* (fxvector-ref a (+ (* r n) k))
                  (fxvector-ref b (+ (* k n) col))))))
    (fxvector-set! c (+ (* r n) col) sum)))

(define total
  (for/fold ([total 0]) ([e (in-range elems)])
    (+ total (fxvector-ref c e))))

(eprintf "TIME_MS=~a\n" (elapsed-ms))
(displayln total)
