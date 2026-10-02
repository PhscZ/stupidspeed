;; task 04 array_sum — expected output: 499999500000
;; build: ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) \
;;            (setf c::*cc* "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe" c::*ld* c::*cc*) \
;;            (si:setenv "INCLUDE" "C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared") \
;;            (si:setenv "LIB" "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64") \
;;            (compile-file "04_array_sum.lisp" :output-file "04_array_sum.fas") (ext:quit))"
;; run: ecl.exe --norc --eval "(load \"04_array_sum.fas\" :verbose nil)"
;; note: ECL's compile-file routes the C it generates through a C compiler, and falls back to
;;       its bytecode compiler without one. That fallback is silent and the loops then run
;;       5-10x slower, so the build points c::*cc* at the MSVC tree under tools/ and gives
;;       cl.exe the INCLUDE and LIB it needs; nothing of that is on PATH on this host.
;; note: the run line is `--eval "(load ... :verbose nil)"` and not `--load`, because --load
;;       writes ";;; Loading #P\"...\"" to stdout and each task prints one line and nothing else.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0))) plus fixnum declarations is what
;;       makes these loops tight; without them every step goes through generic arithmetic.
;; note: the array is declared :element-type 'fixnum, so ECL allocates one unboxed 64-bit
;;       word per slot -- 8 MB, the same shape as the C row's long[1000000]. A general vector
;;       would hold tagged pointers and the read-back would be pointer chasing, not a scan.
(declaim (optimize (speed 3) (safety 0) (debug 0)))

;; Fill a million fixnums, then read them back in order. 499999500000 is below 2^61, so the
;; accumulator stays a fixnum.
(defun main ()
  (let ((arr (make-array 1000000 :element-type 'fixnum))
        (total 0))
    (declare (type (simple-array fixnum (*)) arr)
             (fixnum total))
    (dotimes (i 1000000)
      (declare (fixnum i))
      (setf (aref arr i) i))
    (dotimes (i 1000000)
      (declare (fixnum i))
      (incf total (aref arr i)))
    (format t "~a~%" total)))

(main)
(ext:quit)
