;; task 03 func_sum — expected output: 100000000
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 03_func_sum.ss
;; note: add-one lives in its own file, 03_func_sum_add_one.ss, the same two-file shape the
;;       Fortran, Tcl, Vala, SystemVerilog and Racket rows use for this task. Chez has no
;;       no-inline declaration, and none is needed here: `load` reads and compiles one file
;;       at a time, so add-one is a global holding a compiled procedure and the caller emits
;;       a global call rather than an inlined copy. (Chez's `compile-program`, which would
;;       compile both files as one unit and could inline across them, is deliberately not
;;       used.)
;; note: measured, not assumed. The same 100000000-step loop takes 0.037 s with `(+ value 1)`
;;       written inline, 0.120 s calling the loaded add-one and 0.117 s calling a lambda that
;;       was only bound at run time -- so the loaded call costs what an unknowable call costs
;;       and is 3.3x the inlined form. It is a real call.
;; note: Chez compiles the loaded file into machine code before the loop starts, so this
;;       measures the call, not an interpreter dispatch.
;; note: `load` resolves its argument against the process working directory, not against the
;;       script's directory, so this task has to be run from the directory holding both
;;       files (`scheme --optimize-level 3 --script 03_func_sum.ss`, not a path to the file
;;       from somewhere else). Running it by path from another directory stops with
;;       "failed for 03_func_sum_add_one.ss: no such file or directory".

(load "03_func_sum_add_one.ss")

(let loop ([i 0] [value 0])
  (if (fx= i 100000000)
      (begin (display value) (newline))
      (loop (fx+ i 1) (add-one value))))
