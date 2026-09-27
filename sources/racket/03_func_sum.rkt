;; task 03 func_sum — expected output: 100000000
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 03_func_sum.rkt
;; note: Racket.exe is the console launcher. GRacket.exe is the GUI-subsystem build of
;;       the same runtime and prints nothing to a console.
;; note: #lang racket/base rather than #lang racket, which is the documented way to get a
;;       faster start-up; every form these tasks need is in racket/base.
;; note: the loops are `for`/`for/fold` accumulators or named `let` loops, not `set!` on a
;;       loop local. Racket's own performance chapter measures `set!` in a hot loop as
;;       allocating a fresh location per iteration, so mutation of a loop variable is the
;;       slow way to write it here and the accumulator is the fast way.
#lang racket/base

;; A hundred million calls to a one-line function that lives in its own file, the same
;; two-file shape the Fortran, Tcl and Vala rows use for this task, so the call is not folded
;; away. Racket has no no-inline marker, but its own manual says cross-module inlining is
;; conservative and only considers trivial functions -- add-one is trivial, so the JIT may
;; still inline it, which is the same caveat the Java and Clojure rows record.
(require "03_func_sum_add_one.rkt")

(define total
  (for/fold ([value 0]) ([i (in-range 100000000)])
    (add-one value)))

(displayln total)
