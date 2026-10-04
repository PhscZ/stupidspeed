;; task 15 file_write — expected output: 52428800
;; build: sbcl --non-interactive --no-userinit --no-sysinit --load 15_file_write.lisp \
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
;; note: the 1 MiB buffer is written 50 times, then force-output and close. Common Lisp has
;;       no standard fsync, so the deviation is force-output plus close -- the same one the Tcl,
;;       D, Julia, Nim, Dart, Pascal, COBOL and Dolphin rows note.

(declaim (optimize (speed 3) (safety 0) (debug 0)))

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
  (let ((len 1048576)
        (buf (make-array 1048576 :element-type '(unsigned-byte 8))))
    (dotimes (i len)
      (declare (fixnum i))
      (setf (aref buf i) (mod i 256)))
    (with-open-file (out "out.bin" :direction :output :if-exists :supersede
                                      :element-type '(unsigned-byte 8))
      (dotimes (i 50)
        (declare (fixnum i))
        (write-sequence buf out))
      (force-output out))
    (format *error-output* "TIME_MS=~,3f~%" (elapsed-ms))
    (format t "~a~%" (* 50 len))))
