;; task 07 string_append — expected output: 250000
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 07_string_append.ss
;; note: plain string concatenation 250000 times. Chez strings are fixed-length and
;;       immutable, so every append allocates a new string and copies the old one, which is
;;       the same quadratic copy the C row's realloc plus strcat does. Deliberately no string
;;       port, no string builder and no growable string: this cell is meant to measure the
;;       quadratic cost, exactly as the Racket row's does.

;; text = text + "x", 250000 times.
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
(let loop ([i 0] [text ""])
  (if (fx= i 250000)
      (begin (ss-report) (display (string-length text)) (newline))
      (loop (fx+ i 1) (string-append text "x"))))
