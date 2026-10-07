;; task 14 file_read — expected output: 2389704704
;; build: sbcl --non-interactive --no-userinit --no-sysinit --load 14_file_read.lisp \
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
;; note: data.bin is read from the working directory in 1 MiB chunks and every byte is added
;;       up; the running total is reduced mod 2^32 after each chunk so it stays inside the 2^53
;;       range where a double float is exact. The buffer is an (unsigned-byte 8) array, so each
;;       element is already 0..255 and no sign masking is needed.

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
  (let ((buf (make-array 1048576 :element-type '(unsigned-byte 8)))
        (total 0))
    (declare (type (signed-byte 64) total))
    (with-open-file (in "data.bin" :direction :input :element-type '(unsigned-byte 8))
      (loop for n = (read-sequence buf in)
            while (plusp n)
            do (dotimes (i n)
                 (declare (fixnum i))
                 (incf total (aref buf i)))
               (setf total (mod total 4294967296))))
    (format *error-output* "TIME_MS=~,3f~%" (elapsed-ms))
    (format t "~a~%" total)))
