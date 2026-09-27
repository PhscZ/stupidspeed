;; task 07 string_append — expected output: 1000000
;; build: sbcl --non-interactive --no-userinit --no-sysinit --load 07_string_append.lisp \
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

;; Plain string concatenation a million times. Common Lisp strings are mutable, but concatenate
;; allocates a fresh string and copies both arguments on every call, which is the same quadratic
;; copy the C row's realloc plus strcat does. Deliberately no adjustable vector and no fill
;; pointer, either of which would make this linear.
(defun main ()
  (let ((text ""))
    (dotimes (i 1000000)
      (declare (fixnum i))
      (setf text (concatenate 'string text "x")))
    (format t "~a~%" (length text))))
