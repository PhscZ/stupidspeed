;; task 14 file_read — expected output: 2389704704
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 14_file_read.ss
;; note: data.bin is read from the working directory in 1 MiB chunks with
;;       get-bytevector-n!, so the port does one read per chunk and never a syscall per
;;       byte, and every byte in the chunk is then added one at a time in an inner loop.
;; note: bytevector-u8-ref already yields 0..255, so unlike the JVM rows there is no sign
;;       masking to do. The running total is reduced mod 2^32 once at the end, the same
;;       place the C row does it; 50 MiB of bytes is about 6.7e9, far inside the fixnum
;;       range, so nothing overflows before the reduction.
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

(define chunk 1048576)
(define buf (make-bytevector chunk 0))
(define in (open-file-input-port "data.bin"))

(define total
  (let chunks ([total 0])
    (let ([got (get-bytevector-n! in buf 0 chunk)])
      (if (eof-object? got)
          total
          (chunks (fx+ total
                       (let scan ([i 0] [s 0])
                         (if (fx= i got)
                             s
                             (scan (fx+ i 1) (fx+ s (bytevector-u8-ref buf i)))))))))))

(close-port in)
(ss-report)
(display (fxmod total 4294967296))
(newline)
