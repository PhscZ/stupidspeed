;; task 07 string_append — expected output: 250000
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 07_string_append.rkt
;; note: Racket.exe is the console launcher. GRacket.exe is the GUI-subsystem build of
;;       the same runtime and prints nothing to a console.
;; note: #lang racket/base rather than #lang racket, which is the documented way to get a
;;       faster start-up; every form these tasks need is in racket/base.
;; note: the loops are `for`/`for/fold` accumulators or named `let` loops, not `set!` on a
;;       loop local. Racket's own performance chapter measures `set!` in a hot loop as
;;       allocating a fresh location per iteration, so mutation of a loop variable is the
;;       slow way to write it here and the accumulator is the fast way.
#lang racket/base

;; Self-timing: current-inexact-milliseconds is Racket's monotonic wall-clock reading, in
;; milliseconds as an inexact real. The start is the first form the module body runs and the
;; stop is taken immediately before the answer is printed, so the bracketed region is the
;; task's own work and nothing else. eprintf writes to (current-error-port), so stdout is
;; unchanged.
(define timer-start (current-inexact-milliseconds))
(define (elapsed-ms) (- (current-inexact-milliseconds) timer-start))

;; Plain string concatenation 250000 times. Racket strings are immutable, so every append
;; allocates a new string and copies the old one, which is the same quadratic copy the C row's
;; realloc plus strcat does. Deliberately no port and no string builder.
(define text
  (for/fold ([text ""]) ([i (in-range 250000)])
    (string-append text "x")))

(eprintf "TIME_MS=~a\n" (elapsed-ms))
(displayln (string-length text))
