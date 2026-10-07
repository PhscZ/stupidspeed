;; task 09 fib_recursive — expected output: 102334155
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 09_fib_recursive.ss
;; note: naive fib(40): about 331 million calls, so this measures the call path itself
;;       rather than any arithmetic. Each level is a real call; the two recursive calls are
;;       not in tail position, so nothing is turned into a loop.
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

(define (fib n)
  (if (fx< n 2)
      n
      (fx+ (fib (fx- n 1)) (fib (fx- n 2)))))

;; the work is evaluated into a variable first: computing it inside the display argument
;; list would place all 331 million calls after the timer stops.
(define ss-r (fib 40))
(ss-report)
(display ss-r)
(newline)
