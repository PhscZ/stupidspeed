;; task 06 char_count — expected output: 10000000
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 06_char_count.rkt
;; note: Racket.exe is the console launcher. GRacket.exe is the GUI-subsystem build of
;;       the same runtime and prints nothing to a console.
;; note: #lang racket/base rather than #lang racket, which is the documented way to get a
;;       faster start-up; every form these tasks need is in racket/base.
;; note: the loops are `for`/`for/fold` accumulators or named `let` loops, not `set!` on a
;;       loop local. Racket's own performance chapter measures `set!` in a hot loop as
;;       allocating a fresh location per iteration, so mutation of a loop variable is the
;;       slow way to write it here and the accumulator is the fast way.
#lang racket/base

;; The 100 MB text is built once by doubling the ten-character block, which is O(log n)
;; appends rather than a hundred million of them, and then scanned one character at a time.
;; The build writes into a single preallocated mutable string and doubles in place, so the
;; peak is the 100 MB string itself and not two or three copies of it.
(define n 100000000)
(define text (make-string n #\a))
(string-copy! text 0 "abcdefghij")
(let build ([k 10])
  (when (< k n)
    (string-copy! text k text 0 (min k (- n k)))
    (build (* 2 k))))

(define count
  (for/fold ([count 0]) ([i (in-range n)])
    (if (char=? (string-ref text i) #\h) (add1 count) count)))

(displayln count)
