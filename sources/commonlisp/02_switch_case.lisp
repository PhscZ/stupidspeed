;; task 02 switch_case — expected output: 7500000075000000
;; build: sbcl --non-interactive --no-userinit --no-sysinit --load 02_switch_case.lisp \
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

;; The accumulator is declared (signed-byte 64), not fixnum. With (safety 0) a fixnum sum
;; would wrap silently and print a wrong answer; 7500000075000000 fits a 64-bit signed integer
;; comfortably, so this type is both exact and unboxed.
(defun main ()
  (let ((acc 0))
    (declare (type (signed-byte 64) acc))
    (dotimes (i 100000000)
      (declare (fixnum i))
      (incf acc (case (mod i 4)
                  (0 1)
                  (1 i)
                  (2 (* 2 i))
                  (otherwise (* 3 i)))))
    (format t "~a~%" acc)))
