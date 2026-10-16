#lang racket/base

;; task 03 func_sum — helper module, the second translation unit.
;; A separate file so the call to add-one crosses a module boundary, the same reason the
;; Fortran, Tcl and Vala rows split this task. The function is trivial, and Racket's own manual
;; says its cross-module inliner only considers trivial functions, so it may still be inlined
;; -- that is noted in 03_func_sum.rkt rather than worked around.

(provide add-one)

(define (add-one n)
  (+ n 1))
