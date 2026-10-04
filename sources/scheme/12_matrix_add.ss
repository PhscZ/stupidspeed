;; task 12 matrix_add — expected output: 999000000
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 12_matrix_add.ss
;; note: three flat 1000x1000 fxvectors, row-major, filled and added with plain index
;;       arithmetic. Flat packed vectors are the contiguous array here, the same choice the
;;       Racket row makes; a vector of vectors would add a pointer chase per element.
;; note: the sum of C fits a fixnum (999000000), so the accumulation stays on the fixnum
;;       fast path.
;; timing: (real-time) is Chez's monotonic clock in milliseconds since system start-up;
;;         TIME_MS is written to time.txt, the contract's fallback, because Chez's
;;         console-error-port is the console and this host sends the console to stdout
;;         when it is redirected; stdout is unchanged.
(define ss-t0 (real-time))
(define (ss-report)
  (let ([p (open-file-output-port "time.txt" (file-options no-fail)
                                  (buffer-mode block))])
    (put-bytevector p (string->utf8
                       (string-append "TIME_MS="
                                      (number->string (- (real-time) ss-t0))
                                      "\n")))
    (close-port p)))

(define n 1000)
(define elems (* n n))
(define a (make-fxvector elems))
(define b (make-fxvector elems))
(define c (make-fxvector elems))

(let row ([i 0])
  (when (fx< i n)
    (let col ([j 0])
      (when (fx< j n)
        (let ([idx (fx+ (fx* i n) j)])
          (fxvector-set! a idx (fx+ i j))
          (fxvector-set! b idx (fx- i j)))
        (col (fx+ j 1))))
    (row (fx+ i 1))))

(let row ([p 0])
  (when (fx< p n)
    (let col ([q 0])
      (when (fx< q n)
        (let ([idx (fx+ (fx* p n) q)])
          (fxvector-set! c idx (fx+ (fxvector-ref a idx) (fxvector-ref b idx))))
        (col (fx+ q 1))))
    (row (fx+ p 1))))

(let loop ([k 0] [total 0])
  (if (fx= k elems)
      (begin (ss-report) (display total) (newline))
      (loop (fx+ k 1) (fx+ total (fxvector-ref c k)))))
