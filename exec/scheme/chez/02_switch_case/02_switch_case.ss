;; task 02 switch_case — expected output: 7500000075000000
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 02_switch_case.ss
;; note: `case` is Scheme's switch. Chez compiles a case whose keys are the fixnums 0..3 into
;;       a jump table, so this is the same four-way dispatch the C row's `switch` gets.
;; note: the accumulator reaches 7500000075000000, which is about 7.5e15. Chez's fixnums are
;;       61 bits wide on x86-64, so the whole sum stays a fixnum and fx+ is exact. A wider
;;       value would promote to a bignum and fx+ would signal an error instead, which is why
;;       the bound is checked rather than assumed.

;; case on (fxmod i 4) with a single accumulator carried as a named-let argument.
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
(let loop ([i 0] [acc 0])
  (if (fx= i 100000000)
      (begin (ss-report) (display acc) (newline))
      (loop (fx+ i 1)
            (fx+ acc (case (fxmod i 4)
                       [(0) 1]
                       [(1) i]
                       [(2) (fx* 2 i)]
                       [else (fx* 3 i)])))))
