;; task 14 file_read — expected output: 2389704704
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 14_file_read.rkt
;; note: Racket.exe is the console launcher. GRacket.exe is the GUI-subsystem build of
;;       the same runtime and prints nothing to a console.
;; note: #lang racket/base rather than #lang racket, which is the documented way to get a
;;       faster start-up; every form these tasks need is in racket/base.
;; note: the loops are `for`/`for/fold` accumulators or named `let` loops, not `set!` on a
;;       loop local. Racket's own performance chapter measures `set!` in a hot loop as
;;       allocating a fresh location per iteration, so mutation of a loop variable is the
;;       slow way to write it here and the accumulator is the fast way.
;; note: data.bin is read from the working directory in 1 MiB chunks and every byte is added
;;       up; the running total is reduced mod 2^32 after each chunk so it stays inside the 2^53
;;       range where an inexact real is exact. bytes-ref already yields 0..255, so unlike the
;;       JVM rows there is no sign masking to do.

#lang racket/base

(define in (open-input-file "data.bin"))

(define total
  (let chunk ([total 0])
    (define buf (read-bytes 1048576 in))
    (if (eof-object? buf)
        total
        (chunk (modulo (+ total
                          (let scan ([i 0] [s 0])
                            (if (< i (bytes-length buf))
                                (scan (add1 i) (+ s (bytes-ref buf i)))
                                s)))
                       4294967296)))))

(close-input-port in)
(displayln total)
