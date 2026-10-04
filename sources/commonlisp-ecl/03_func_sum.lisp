;; task 03 func_sum — expected output: 100000000
;; build: ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) \
;;            (setf c::*cc* "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe" c::*ld* c::*cc*) \
;;            (si:setenv "INCLUDE" "C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared") \
;;            (si:setenv "LIB" "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64") \
;;            (compile-file "03_func_sum.lisp" :output-file "03_func_sum.fas") (ext:quit))"
;; run: ecl.exe --norc --eval "(load \"03_func_sum.fas\" :verbose nil)"
;; note: ECL's compile-file routes the C it generates through a C compiler, and falls back to
;;       its bytecode compiler without one. That fallback is silent and the loops then run
;;       5-10x slower, so the build points c::*cc* at the MSVC tree under tools/ and gives
;;       cl.exe the INCLUDE and LIB it needs; nothing of that is on PATH on this host.
;; note: the run line is `--eval "(load ... :verbose nil)"` and not `--load`, because --load
;;       writes ";;; Loading #P\"...\"" to stdout and each task prints one line and nothing else.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0))) plus fixnum declarations is what
;;       makes these loops tight; without them every step goes through generic arithmetic.
;; note: (declaim (notinline add-one)) is the marker this task asks for, and it is load
;;       bearing: ECL's compiler will otherwise inline a one-line function called with a known
;;       fixnum argument and the hundred million calls disappear into the loop body. The
;;       declaim comes before the defun and the file is compiled as one unit, so it applies.
;; note: the loop uses the return value of add-one rather than incrementing a counter, so the
;;       call cannot be dropped as dead code.
(declaim (optimize (speed 3) (safety 0) (debug 0)))
(declaim (notinline add-one))
(declaim (ftype (function (fixnum) fixnum) add-one))

(defun add-one (n)
  (declare (fixnum n))
  (the fixnum (+ n 1)))

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
  (let ((value 0))
    (declare (fixnum value))
    (dotimes (i 100000000)
      (declare (fixnum i))
      (setf value (add-one value)))
    (format *error-output* "TIME_MS=~,3f~%" (elapsed-ms))
    (format t "~a~%" value)))

(main)
(ext:quit)
