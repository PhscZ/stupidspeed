;; task 15 file_write — expected output: 52428800
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 15_file_write.rkt
;; note: Racket.exe is the console launcher. GRacket.exe is the GUI-subsystem build of
;;       the same runtime and prints nothing to a console.
;; note: #lang racket/base rather than #lang racket, which is the documented way to get a
;;       faster start-up; every form these tasks need is in racket/base.
;; note: the loops are `for`/`for/fold` accumulators or named `let` loops, not `set!` on a
;;       loop local. Racket's own performance chapter measures `set!` in a hot loop as
;;       allocating a fresh location per iteration, so mutation of a loop variable is the
;;       slow way to write it here and the accumulator is the fast way.
;; note: the 1 MiB buffer is written 50 times and then flushed and closed. Racket exposes no
;;       fsync on a file port, so the deviation is flush plus close -- the same one the Tcl, D,
;;       Julia, Nim, Dart, Pascal, COBOL and Dolphin rows note.

#lang racket/base

;; Self-timing: current-inexact-milliseconds is Racket's monotonic wall-clock reading, in
;; milliseconds as an inexact real. The start is the first form the module body runs and the
;; stop is taken immediately before the answer is printed, so the bracketed region is the
;; task's own work and nothing else. eprintf writes to (current-error-port), so stdout is
;; unchanged.
(define timer-start (current-inexact-milliseconds))
(define (elapsed-ms) (- (current-inexact-milliseconds) timer-start))

(define len 1048576)
(define buf (make-bytes len))

(for ([i (in-range len)])
  (bytes-set! buf i (modulo i 256)))

(define out (open-output-file "out.bin" #:exists 'truncate/replace))

(for ([i (in-range 50)])
  (write-bytes buf out))

(flush-output out)
(close-output-port out)

(eprintf "TIME_MS=~a\n" (elapsed-ms))
(displayln (* 50 len))
