;; task 08 average — expected output: 0.498046875
;; build: sbcl --non-interactive --no-userinit --no-sysinit --load 08_average.lisp \
;;            --eval "(sb-ext:save-lisp-and-die \"prog.exe\" :executable t :toplevel (function main) :application-type :console)"
;; run: prog.exe
;; note: the build dumps a standalone executable once, so the timed run pays the core's
;;       start-up and not the reader/compiler as well. `sbcl --script <task>.lisp` also
;;       works and is the development form, but it re-reads and re-compiles the source on
;;       every run.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0))) plus fixnum declarations is
;;       what makes these loops tight; without them the compiler cannot assume the
;;       arithmetic fits a machine word and every step goes through generic arithmetic.
;; note: SBCL's Windows x86-64 port has real OS threads -- (find :sb-thread *features*) is
;;       true and threads are a required part of the win32 build, implemented over
;;       _beginthreadex. There is no global interpreter lock.
;; note: loops are `loop`/`dotimes` with setf/incf. mapcar and reduce are avoided in the
;;       timed paths because they cons and hide the loop body from type inference.
(declaim (optimize (speed 3) (safety 0) (debug 0)))

;; A hundred million readings, each a multiple of 1/256, accumulated as a double float. The
;; total is far below 2^53, so the sum is exact and the digits do not depend on the order of
;; addition. ~,9f rather than ~a because SBCL prints a double float with its exponent marker
;; (~a gives "0.498046875d0"), and the benchmark's expected line has no marker in it. Nine
;; digits after the point is exactly the precision of the answer, which is a multiple of 1/512.
(defun main ()
  (let ((total 0.0d0))
    (declare (type double-float total))
    (dotimes (i 100000000)
      (declare (fixnum i))
      (setf total (+ total (/ (coerce (mod i 256) 'double-float) 256.0d0))))
    (format t "~,9f~%" (/ total 100000000.0d0))))
