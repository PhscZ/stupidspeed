;; task 02 switch_case — expected output: 7500000075000000
;; build: ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) \
;;            (setf c::*cc* "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe" c::*ld* c::*cc*) \
;;            (si:setenv "INCLUDE" "C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared") \
;;            (si:setenv "LIB" "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64") \
;;            (compile-file "02_switch_case.lisp" :output-file "02_switch_case.fas") (ext:quit))"
;; run: ecl.exe --norc --eval "(load \"02_switch_case.fas\" :verbose nil)"
;; note: ECL's compile-file routes the C it generates through a C compiler, and falls back to
;;       its bytecode compiler without one. That fallback is silent and the loops then run
;;       5-10x slower, so the build points c::*cc* at the MSVC tree under tools/ and gives
;;       cl.exe the INCLUDE and LIB it needs; nothing of that is on PATH on this host.
;; note: the run line is `--eval "(load ... :verbose nil)"` and not `--load`, because --load
;;       writes ";;; Loading #P\"...\"" to stdout and each task prints one line and nothing else.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0))) plus fixnum declarations is what
;;       makes these loops tight; without them every step goes through generic arithmetic.
;; note: the accumulator is fixnum rather than (signed-byte 64). ECL's fixnum is 62 bits on
;;       x86-64, and 7500000075000000 is below 2^53, so it fits with room to spare -- but a
;;       (signed-byte 64) declaration would have included bignums and cost generic arithmetic.
(declaim (optimize (speed 3) (safety 0) (debug 0)))

;; The same four-way decision as task 01 with a different predicate, written as `case` on
;; (mod i 4). `case` on a small integer is what a switch is in Common Lisp.
(defun main ()
  (let ((acc 0))
    (declare (fixnum acc))
    (dotimes (i 100000000)
      (declare (fixnum i))
      (incf acc (case (mod i 4)
                  (0 1)
                  (1 i)
                  (2 (* 2 i))
                  (t (* 3 i)))))
    (format t "~a~%" acc)))

(main)
(ext:quit)
