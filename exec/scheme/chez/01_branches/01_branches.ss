;; task 01 branches — expected output: 33333334 13333333 7619048 45714285
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 01_branches.ss
;; note: the loop is a named let carrying the four counters as arguments, so every step is a
;;       tail call and there is no mutation anywhere. Chez's `do` and `set!` forms work too
;;       and measure the same loop; the accumulator form is the one every other row uses.
;; note: the arithmetic is the fixnum-specific `fx` family (fx+, fxmod, fx=), which is what
;;       the Common Lisp row's fixnum declarations buy. Every counter here is far inside the
;;       fixnum range, so no step can promote or overflow.

;; Four counters and one if/else chain over a hundred million iterations, the same nested
;; test as every other row.
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
(let loop ([i 0] [a 0] [b 0] [c 0] [d 0])
  (if (fx= i 100000000)
      (begin (ss-report) (printf "~a ~a ~a ~a~%" a b c d))
      (let ([next (fx+ i 1)])
        (cond [(fx= 0 (fxmod i 3)) (loop next (fx+ a 1) b c d)]
              [(fx= 0 (fxmod i 5)) (loop next a (fx+ b 1) c d)]
              [(fx= 0 (fxmod i 7)) (loop next a b (fx+ c 1) d)]
              [else (loop next a b c (fx+ d 1))]))))
