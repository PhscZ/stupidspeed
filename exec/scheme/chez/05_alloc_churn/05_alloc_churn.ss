;; task 05 alloc_churn — expected output: 1274991808
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 05_alloc_churn.ss
;; note: ten million 64-byte bytevectors, each stored into one of 256 slots so the buffer it
;;       replaces becomes garbage -- the same reachability line the C and Java rows draw, and
;;       the reason Chez's collector has something to do here. The total adds v, the value
;;       written, exactly as the Java row does.
;; note: bytevectors are the unboxed byte array (Chez's R6RS name for `bytes`), so each
;;       allocation is one 64-byte block plus a header, not 64 boxed objects.
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

(define slots (make-vector 256 #f))

(let loop ([i 0] [total 0])
  (if (fx= i 10000000)
      (begin (ss-report) (display total) (newline))
      (let ([v (fxmod i 256)])
        (let ([buf (make-bytevector 64 0)])
          (bytevector-u8-set! buf 0 v)
          (vector-set! slots v buf))
        (loop (fx+ i 1) (fx+ total v)))))
