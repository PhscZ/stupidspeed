;; task 12 matrix_add — expected output: 999000000
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 12_matrix_add.rkt
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

;; Three flat 1000x1000 fxvectors, row-major, filled and added with plain index arithmetic.
;; The total fits a fixnum.
(define n 1000)
(define elems (* n n))
(define a (make-fxvector elems))
(define b (make-fxvector elems))
(define c (make-fxvector elems))

(for ([i (in-range n)])
  (for ([j (in-range n)])
    (define idx (+ (* i n) j))
    (fxvector-set! a idx (+ i j))
    (fxvector-set! b idx (- i j))))

(for ([p (in-range n)])
  (for ([q (in-range n)])
    (define idx (+ (* p n) q))
    (fxvector-set! c idx (+ (fxvector-ref a idx) (fxvector-ref b idx)))))

(define total
  (for/fold ([total 0]) ([k (in-range elems)])
    (+ total (fxvector-ref c k))))

(displayln total)
