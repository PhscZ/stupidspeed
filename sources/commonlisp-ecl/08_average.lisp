;; task 08 average — expected output: 0.498046875
;; build: ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) \
;;            (setf c::*cc* "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe" c::*ld* c::*cc*) \
;;            (si:setenv "INCLUDE" "C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared") \
;;            (si:setenv "LIB" "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64") \
;;            (compile-file "08_average.lisp" :output-file "08_average.fas") (ext:quit))"
;; run: ecl.exe --norc --eval "(load \"08_average.fas\" :verbose nil)"
;; note: ECL's compile-file routes the C it generates through a C compiler, and falls back to
;;       its bytecode compiler without one. That fallback is silent and the loops then run
;;       5-10x slower, so the build points c::*cc* at the MSVC tree under tools/ and gives
;;       cl.exe the INCLUDE and LIB it needs; nothing of that is on PATH on this host.
;; note: the run line is `--eval "(load ... :verbose nil)"` and not `--load`, because --load
;;       writes ";;; Loading #P\"...\"" to stdout and each task prints one line and nothing else.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0))) plus fixnum declarations is what
;;       makes these loops tight; without them every step goes through generic arithmetic.
;; note: the accumulator is a double-float and the loop is declared so, or ECL would keep it
;;       boxed and every addition would allocate. ~,9f rather than ~a because ECL prints a
;;       double with its exponent marker (~a gives "0.498046875d0") and the expected line has
;;       no marker in it; nine digits after the point is exactly the precision of the answer.
(declaim (optimize (speed 3) (safety 0) (debug 0)))

;; A hundred million readings, each an exact multiple of 1/256, accumulated as a double float.
;; The total stays far below 2^53, so the sum is exact and the digits do not depend on the
;; order of addition.
(defun main ()
  (let ((total 0.0d0))
    (declare (type double-float total))
    (dotimes (i 100000000)
      (declare (fixnum i))
      (incf total (/ (coerce (mod i 256) 'double-float) 256.0d0)))
    (format t "~,9f~%" (/ total 100000000.0d0))))

(main)
(ext:quit)
