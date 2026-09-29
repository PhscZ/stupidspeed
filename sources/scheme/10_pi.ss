;; task 10 pi — expected output: 4470
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 10_pi.ss
;; note: Chez's exact integers are arbitrary precision -- the User's Guide says a bignum is
;;       used for any exact integer outside the fixnum range -- so unlike most rows this one
;;       does NOT hand-roll base-1e9 limbs. Fixnums promote to bignums automatically, and
;;       quotient is a real bignum division rather than the repeated subtraction the
;;       hand-rolled rows use. Same note as the Racket row.

;; Gibbons' unbounded spigot over Chez's built-in exact integers. A named let carries the
;; whole state; n stays small because it is always a single digit, while q, r and t grow to
;; roughly 16000 limbs. Only the sum of the digits is printed.
(define sum
  (let loop ([q 1] [r 0] [t 1] [k 1] [l 3] [n 3] [produced 0] [sum 0])
    (if (fx< produced 1000)
        (let ([u (+ (* 4 q) r)]
              [v (* (+ n 1) t)])
          (if (< u v)
              ;; n is settled: emit it and advance
              (let* ([u2 (* 10 (+ (* 3 q) r))]
                     [next-n (- (quotient u2 t) (* 10 n))]
                     [r2 (* 10 (- r (* n t)))])
                (loop (* 10 q) r2 t k l next-n (fx+ produced 1) (+ sum n)))
              ;; not settled: widen the state by one more term
              (let* ([u3 (+ (* q (+ 1 (* 7 k))) (* r l))]
                     [next-n (quotient u3 (* t l))]
                     [r2 (* (+ (* 2 q) r) l)])
                (loop (* q k) r2 (* t l) (+ k 1) (+ l 2) next-n produced sum))))
        sum)))

(display sum)
(newline)
