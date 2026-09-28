;; task 10 pi — expected output: 4470
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 10_pi.rkt
;; note: Racket.exe is the console launcher. GRacket.exe is the GUI-subsystem build of
;;       the same runtime and prints nothing to a console.
;; note: #lang racket/base rather than #lang racket, which is the documented way to get a
;;       faster start-up; every form these tasks need is in racket/base.
;; note: the loops are `for`/`for/fold` accumulators or named `let` loops, not `set!` on a
;;       loop local. Racket's own performance chapter measures `set!` in a hot loop as
;;       allocating a fresh location per iteration, so mutation of a loop variable is the
;;       slow way to write it here and the accumulator is the fast way.
;; note: Racket has exact arbitrary-precision integers built in -- the reference says their
;;       size is limited only by memory -- so unlike most rows this one does NOT hand-roll
;;       base-1e9 limbs. Fixnums promote to bignums automatically, and quotient is a real
;;       bignum division rather than the repeated subtraction the hand-rolled rows use.

#lang racket/base

;; Gibbons' unbounded spigot over Racket's built-in exact integers. A named let carries the
;; whole state; n stays small because it is always a single digit, while q, r and t grow to
;; roughly 16000 limbs. Only the sum of the digits is printed.
(define sum
  (let loop ([q 1] [r 0] [t 1] [k 1] [l 3] [n 3] [produced 0] [sum 0])
    (if (< produced 1000)
        (let ([u (+ (* 4 q) r)]
              [v (* (+ n 1) t)])
          (if (< u v)
              ;; n is settled: emit it and advance
              (let* ([u2 (* 10 (+ (* 3 q) r))]
                     [next-n (- (quotient u2 t) (* 10 n))]
                     [r2 (* 10 (- r (* n t)))])
                (loop (* 10 q) r2 t k l next-n (add1 produced) (+ sum n)))
              ;; not settled: widen the state by one more term
              (let* ([u3 (+ (* q (+ 1 (* 7 k))) (* r l))]
                     [next-n (quotient u3 (* t l))]
                     [r2 (* (+ (* 2 q) r) l)])
                (loop (* q k) r2 (* t l) (add1 k) (+ l 2) next-n produced sum))))
        sum)))

(displayln sum)
