;; task 01 branches — expected output: 33333334 13333333 7619048 45714285
;; build: sbcl --non-interactive --no-userinit --no-sysinit --load 01_branches.lisp \
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

(defun main ()
  (let ((a 0) (b 0) (c 0) (d 0))
    (declare (fixnum a b c d))
    (dotimes (i 100000000)
      (declare (fixnum i))
      (cond ((= 0 (mod i 3)) (incf a))
            ((= 0 (mod i 5)) (incf b))
            ((= 0 (mod i 7)) (incf c))
            (t (incf d))))
    (format t "~a ~a ~a ~a~%" a b c d)))
