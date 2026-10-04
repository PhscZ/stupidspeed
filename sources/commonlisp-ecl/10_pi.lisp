;; task 10 pi — expected output: 4470
;; build: ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) \
;;            (setf c::*cc* "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe" c::*ld* c::*cc*) \
;;            (si:setenv "INCLUDE" "C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared") \
;;            (si:setenv "LIB" "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64") \
;;            (compile-file "10_pi.lisp" :output-file "10_pi.fas") (ext:quit))"
;; run: ecl.exe --norc --eval "(load \"10_pi.fas\" :verbose nil)"
;; note: ECL's compile-file routes the C it generates through a C compiler, and falls back to
;;       its bytecode compiler without one. That fallback is silent and the loops then run
;;       5-10x slower, so the build points c::*cc* at the MSVC tree under tools/ and gives
;;       cl.exe the INCLUDE and LIB it needs; nothing of that is on PATH on this host.
;; note: the run line is `--eval "(load ... :verbose nil)"` and not `--load`, because --load
;;       writes ";;; Loading #P\"...\"" to stdout and each task prints one line and nothing else.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0))) plus fixnum declarations is what
;;       makes these loops tight; without them every step goes through generic arithmetic.
;; note: ECL has arbitrary-precision integers natively, so this is the standard-library route,
;;       not the hand-rolled base-1e9 limbs. q, r and tt grow to about 16000 digits and carry
;;       no type declaration, because a fixnum declaration would wrap them silently under
;;       (safety 0); only k, l, n, produced and sum are fixnums, and n is always one digit.
;; note: the spigot's `t` is spelled `tt` here: T is a defined constant in Common Lisp and
;;       cannot be used as a variable name.
(declaim (optimize (speed 3) (safety 0) (debug 0)))

;; Gibbons' unbounded spigot. The state is (q, r, tt, k, n, l) and the two rules below are
;; exactly the ones from the paper; only the sum of the digits is printed.
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
    (format *error-output* "TIME_MS=~,3f~%" (elapsed-ms))
    (format t "~a~%" sum)))

(main)
(ext:quit)
