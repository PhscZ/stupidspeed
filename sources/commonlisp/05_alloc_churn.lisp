;; task 05 alloc_churn — expected output: 1274991808
;; build: sbcl --non-interactive --no-userinit --no-sysinit --load 05_alloc_churn.lisp \
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

;; Ten million 64-byte buffers, each stored into one of 256 slots so the buffer it replaces
;; becomes garbage -- the same reachability line the C and Java rows draw. The running total
;; adds v, the value written, exactly as the Java row does.
(defun main ()
  (let ((slots (make-array 256 :initial-element nil))
        (total 0))
    (declare (fixnum total))
    (dotimes (i 10000000)
      (declare (fixnum i))
      (let* ((v (mod i 256))
             (buf (make-array 64 :element-type '(unsigned-byte 8))))
        (setf (aref buf 0) v)
        (setf (aref slots v) buf)
        (incf total v)))
    (format t "~a~%" total)))
