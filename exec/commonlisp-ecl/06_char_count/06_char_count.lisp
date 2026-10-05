;; task 06 char_count — expected output: 10000000
;; build: ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) \
;;            (setf c::*cc* "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe" c::*ld* c::*cc*) \
;;            (si:setenv "INCLUDE" "C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared") \
;;            (si:setenv "LIB" "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64") \
;;            (compile-file "06_char_count.lisp" :output-file "06_char_count.fas") (ext:quit))"
;; run: ecl.exe --norc --eval "(load \"06_char_count.fas\" :verbose nil)"
;; note: ECL's compile-file routes the C it generates through a C compiler, and falls back to
;;       its bytecode compiler without one. That fallback is silent and the loops then run
;;       5-10x slower, so the build points c::*cc* at the MSVC tree under tools/ and gives
;;       cl.exe the INCLUDE and LIB it needs; nothing of that is on PATH on this host.
;; note: the run line is `--eval "(load ... :verbose nil)"` and not `--load`, because --load
;;       writes ";;; Loading #P\"...\"" to stdout and each task prints one line and nothing else.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0))) plus fixnum declarations is what
;;       makes these loops tight; without them every step goes through generic arithmetic.
;; note: the 100 MB text is built by doubling the ten-character block inside one preallocated
;;       base-string, so the build is O(log n) copies rather than a hundred million appends.
;;       `replace` on a base-string is a memcpy; an adjustable string with a fill pointer
;;       would hide the scan behind pointer arithmetic.
;; note: the :element-type 'base-char is load bearing. ECL's (make-string n) defaults to
;;       (simple-array character (n)), one 4-byte wide character per slot, so the text would
;;       be 400 MB and the scan four times the memory traffic. base-char is ECL's one-byte
;;       character and the whole 100 MB then matches the C row's char[100000000].
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
  (let* ((n 100000000)
         (s (make-string n :element-type 'base-char)))
    (declare (type simple-base-string s))
    (replace s "abcdefghij")
    (loop for k fixnum = 10 then (* k 2)
          while (< k n)
          do (replace s s :start1 k :start2 0 :end2 (min k (- n k))))
    (let ((count 0))
      (declare (fixnum count))
      (dotimes (i n)
        (declare (fixnum i))
        (when (char= (char s i) #\h) (incf count)))
      (format *error-output* "TIME_MS=~,3f~%" (elapsed-ms))
      (format t "~a~%" count))))

(main)
(ext:quit)
