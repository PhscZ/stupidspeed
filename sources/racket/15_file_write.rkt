;; task 15 file_write — expected output: 104857600
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
;; note: the 1 MiB buffer is written 100 times and then flushed and closed. Racket exposes no
;;       fsync on a file port, so the deviation is flush plus close -- the same one the Tcl, D,
;;       Julia, Nim, Dart, Pascal, COBOL and Dolphin rows note.

#lang racket/base

(define len 1048576)
(define buf (make-bytes len))

(for ([i (in-range len)])
  (bytes-set! buf i (modulo i 256)))

(define out (open-output-file "out.bin" #:exists 'truncate/replace))

(for ([i (in-range 100)])
  (write-bytes buf out))

(flush-output out)
(close-output-port out)

(displayln (* 100 len))
