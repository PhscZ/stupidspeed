;; task 10 pi — expected output: 4470
;; build: sbcl --non-interactive --no-userinit --no-sysinit --load 10_pi.lisp \
;;            --eval "(sb-ext:save-lisp-and-die \"prog.exe\" :executable t :toplevel (function main) :application-type :console)"
;; run: prog.exe
;; note: the build dumps a standalone executable once, so the timed run pays the core's
;;       start-up and not the reader/compiler as well. `sbcl --script <task>.lisp` also
;;       works and is the development form, but it re-reads and re-compiles the source on
;;       every run.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0)))

;; Gibbons' unbounded spigot over Common Lisp's built-in exact integers. q, r and tt grow to
;; about 16000 digits; n stays small because it is always a single digit. Only the sum of the
;; digits is printed. The spigot's `t` is spelled `tt` here: T is a defined constant in Common
;; Lisp and cannot be used as a variable name.
;;
;; q, r and tt carry no type declaration, because they leave fixnum range and a fixnum
;; declaration would wrap silently under (safety 0). The small variables are declared fixnum.
(defun main ()
  (let ((q 1) (r 0) (tt 1) (k 1) (l 3) (n 3) (produced 0) (sum 0))
    (declare (fixnum k l n produced sum))
    (loop while (< produced 1000) do
      (let ((u (+ (* 4 q) r))
            (v (* (+ n 1) tt)))
        (if (< u v)
            ;; n is settled: emit it and advance
            (let* ((u2 (* 10 (+ (* 3 q) r)))
                   (next (- (truncate u2 tt) (* 10 n))))
              (setf r (* 10 (- r (* n tt))))
              (setf q (* 10 q))
              (incf sum n)
              (incf produced)
              (setf n next))
            ;; not settled: widen the state by one more term
            (let* ((u3 (+ (* q (+ 1 (* 7 k))) (* r l)))
                   (next (truncate u3 (* tt l))))
              (setf r (* (+ (* 2 q) r) l))
              (setf q (* q k))
              (setf tt (* tt l))
              (incf k)
              (incf l 2)
              (setf n next)))))
    (format t "~a~%" sum)))
