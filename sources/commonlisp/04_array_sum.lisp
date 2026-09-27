;; task 04 array_sum — expected output: 499999500000
;; build: sbcl --non-interactive --no-userinit --no-sysinit --load 04_array_sum.lisp \
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

;; A million-element (simple-array fixnum (*)), filled and then summed in two separate passes so
;; the fill is not part of the read loop. 499999500000 is past 2^31, so the sum is a 64-bit
;; integer rather than a fixnum.
(defun main ()
  (let ((n 1000000))
    (declare (fixnum n))
    (let ((arr (make-array n :element-type 'fixnum)))
      (dotimes (i n) (setf (aref arr i) i))
      (let ((total 0))
        (declare (type (signed-byte 64) total))
        (dotimes (i n) (incf total (aref arr i)))
        (format t "~a~%" total)))))
