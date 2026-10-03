;; task 03 func_sum — helper, the second file.
;; A separate file so the call to add-one is a cross-file call, the same reason the Fortran,
;; Tcl, Vala and Racket rows split this task. Chez has no no-inline marker;
;; the split is what keeps the call out of the caller's compilation unit.

(define (add-one n)
  (+ n 1))
