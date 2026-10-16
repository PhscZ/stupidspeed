;; task 03 func_sum — helper file, the second translation unit.
;; Loaded by 03_func_sum.lisp so the call crosses a file boundary, the same reason the Fortran,
;; Tcl and Vala rows split this task. Standard Common Lisp has no no-inline declaration, and
;; SBCL's compiler may still inline a function this small across a load; that is noted in
;; 03_func_sum.lisp rather than worked around.
(declaim (optimize (speed 3) (safety 0) (debug 0)))

(declaim (ftype (function (fixnum) fixnum) add-one))

(defun add-one (n)
  (declare (fixnum n))
  (the fixnum (1+ n)))
