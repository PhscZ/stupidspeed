# task 03 func_sum — helper module, the second translation unit.
# A separate file so the call to add-one crosses a module boundary, the same reason the
# Fortran, Tcl, Vala and Racket rows split this task. Janet's inliner only runs at
# `:optimize` 2 or higher and user code compiles at level 0, so the call is not folded away
# even though the function is trivial; that is noted in 03_func_sum.janet.
#
# A Janet module exports every top-level binding, so there is no `provide` list to write.

(defn add-one [n]
  (+ n 1))
