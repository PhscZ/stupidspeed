;; task 06 char_count — expected output: 10000000
;; build: sbcl --non-interactive --no-userinit --no-sysinit --load 06_char_count.lisp \
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

;; The 100 MB text is built once by doubling the ten-character block, which is O(log n) copies
;; rather than a hundred million of them, and then scanned one character at a time with char.
;; The doubling happens in place inside the one string, so the peak is the 100 MB string.
(defun main ()
  (let* ((n 100000000)
         (s (make-string n)))
    (replace s "abcdefghij")
    (loop for k fixnum = 10 then (* k 2)
          while (< k n)
          do (replace s s :start1 k :start2 0 :end2 (min k (- n k))))
    (let ((count 0))
      (declare (fixnum count))
      (dotimes (i n)
        (declare (fixnum i))
        (when (char= (char s i) #\h) (incf count)))
      (format t "~a~%" count))))
