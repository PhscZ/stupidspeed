;; task 13 matrix_mul — expected output: 599995000
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 13_matrix_mul.ss
;; note: the plain i, j, k triple loop in that order on flat row-major fxvectors, so the k
;;       loop walks a column of B. Reordering the loops would be faster, which is the point.
;; note: every value stays inside the fixnum range -- A entries are 0..6, B entries 0..4, so
;;       an inner product is at most 500*24 = 12000 -- and the total 599995000 is a fixnum,
;;       so the fx family is exact here.

(define n 500)
(define elems (* n n))
(define a (make-fxvector elems))
(define b (make-fxvector elems))
(define c (make-fxvector elems))

(let row ([i 0])
  (when (fx< i n)
    (let col ([j 0])
      (when (fx< j n)
        (let ([idx (fx+ (fx* i n) j)])
          (fxvector-set! a idx (fxmod (fx+ i j) 7))
          (fxvector-set! b idx (fxmod (fx* i j) 5)))
        (col (fx+ j 1))))
    (row (fx+ i 1))))

(let row ([r 0])
  (when (fx< r n)
    (let col ([cc 0])
      (when (fx< cc n)
        (let sum ([k 0] [acc 0])
          (if (fx= k n)
              (fxvector-set! c (fx+ (fx* r n) cc) acc)
              (sum (fx+ k 1)
                   (fx+ acc (fx* (fxvector-ref a (fx+ (fx* r n) k))
                                 (fxvector-ref b (fx+ (fx* k n) cc)))))))
        (col (fx+ cc 1))))
    (row (fx+ r 1))))

(let loop ([e 0] [total 0])
  (if (fx= e elems)
      (begin (display total) (newline))
      (loop (fx+ e 1) (fx+ total (fxvector-ref c e)))))
