;; task 12 matrix_add — expected output: 999000000
;; build: sbcl --non-interactive --no-userinit --no-sysinit --load 12_matrix_add.lisp \
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

;; Three flat 1000x1000 fixnum arrays, row-major, filled and added with plain index arithmetic.
;; The total fits a fixnum.
;; Self-timing: get-internal-real-time is the monotonic tick counter and
;; internal-time-units-per-second converts ticks to seconds. *timer-start* is set as the
;; first thing main does and read once, immediately before the answer is printed, so the
;; timed region is the task's own work and nothing else. The line goes to *error-output*,
;; so stdout is unchanged.
(defvar *timer-start* 0)

(defun elapsed-ms ()
  (* 1000.0d0 (/ (- (get-internal-real-time) *timer-start*) internal-time-units-per-second)))

(defun main ()
  (setf *timer-start* (get-internal-real-time))
  (let* ((n 1000)
         (elems (* n n))
         (a (make-array elems :element-type 'fixnum))
         (b (make-array elems :element-type 'fixnum))
         (c (make-array elems :element-type 'fixnum)))
    (dotimes (i n)
      (declare (fixnum i))
      (dotimes (j n)
        (declare (fixnum j))
        (let ((idx (+ (* i n) j)))
          (setf (aref a idx) (+ i j))
          (setf (aref b idx) (- i j)))))
    (dotimes (p n)
      (declare (fixnum p))
      (dotimes (q n)
        (declare (fixnum q))
        (let ((idx (+ (* p n) q)))
          (setf (aref c idx) (+ (aref a idx) (aref b idx))))))
    (let ((total 0))
      (declare (type (signed-byte 64) total))
      (dotimes (k elems) (incf total (aref c k)))
      (format *error-output* "TIME_MS=~,3f~%" (elapsed-ms))
      (format t "~a~%" total))))
