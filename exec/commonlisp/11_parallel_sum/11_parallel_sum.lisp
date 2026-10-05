;; task 11 parallel_sum — expected output: 7500000075000000
;; build: sbcl --non-interactive --no-userinit --no-sysinit --load 11_parallel_sum.lisp \
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
;; note: four real OS threads via sb-thread:make-thread, the same shape as the Java row. Each
;;       worker owns a fixed range and writes its partial into a preallocated array, and
;;       join-thread returns the worker's value, so no locking is needed.
;; note: the worker index is bound through a LET rather than closed over directly. A plain
;;       (dotimes (t 4) ... (lambda () (work t))) would capture the one binding and all four
;;       threads would read whatever the variable ended up as, which is the classic
;;       closure-capture trap. The index variable is also not called `t`: T is a defined
;;       constant in Common Lisp and cannot be used as a variable name.

(declaim (optimize (speed 3) (safety 0) (debug 0)))

(defun work (idx)
  (declare (fixnum idx))
  (let ((acc 0))
    (declare (type (signed-byte 64) acc))
    (loop for i fixnum from (* idx 25000000) below (* (+ idx 1) 25000000) do
      (incf acc (case (mod i 4)
                  (0 1)
                  (1 i)
                  (2 (* 2 i))
                  (otherwise (* 3 i)))))
    acc))

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
  (let ((threads
          (loop for n from 0 below 4
                collect (let ((id n))
                          (sb-thread:make-thread
                           (lambda () (work id))
                           :name (format nil "w~a" id))))))
    (let ((total 0))
      (declare (type (signed-byte 64) total))
      (dolist (th threads)
        (incf total (the (signed-byte 64) (sb-thread:join-thread th))))
      (format *error-output* "TIME_MS=~,3f~%" (elapsed-ms))
      (format t "~a~%" total))))
