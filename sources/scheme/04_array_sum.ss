;; task 04 array_sum — expected output: 499999500000
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 04_array_sum.ss
;; note: the array is an fxvector, Chez's vector of unboxed fixnums -- the packed contiguous
;;       array here, and the same choice the Racket row makes. A plain vector would hold
;;       boxed fixnums and measure the indirection instead.
;; note: fill and sum are two separate passes, so the fill is not part of the read loop.

;; A million-element fxvector, filled and then summed.
(define n 1000000)
(define arr (make-fxvector n))

(let fill ([i 0])
  (when (fx< i n)
    (fxvector-set! arr i i)
    (fill (fx+ i 1))))

(let loop ([i 0] [total 0])
  (if (fx= i n)
      (begin (display total) (newline))
      (loop (fx+ i 1) (fx+ total (fxvector-ref arr i)))))
