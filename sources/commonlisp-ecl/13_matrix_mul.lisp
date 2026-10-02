;; task 13 matrix_mul — expected output: 599995000
;; build: ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) \
;;            (setf c::*cc* "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe" c::*ld* c::*cc*) \
;;            (si:setenv "INCLUDE" "C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared") \
;;            (si:setenv "LIB" "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64") \
;;            (compile-file "13_matrix_mul.lisp" :output-file "13_matrix_mul.fas") (ext:quit))"
;; run: ecl.exe --norc --eval "(load \"13_matrix_mul.fas\" :verbose nil)"
;; note: ECL's compile-file routes the C it generates through a C compiler, and falls back to
;;       its bytecode compiler without one. That fallback is silent and the loops then run
;;       5-10x slower, so the build points c::*cc* at the MSVC tree under tools/ and gives
;;       cl.exe the INCLUDE and LIB it needs; nothing of that is on PATH on this host.
;; note: the run line is `--eval "(load ... :verbose nil)"` and not `--load`, because --load
;;       writes ";;; Loading #P\"...\"" to stdout and each task prints one line and nothing else.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0))) plus fixnum declarations is what
;;       makes these loops tight; without them every step goes through generic arithmetic.
;; note: three flat (simple-array fixnum (*)) of 250000, indexed by hand, for the same reason
;;       as task 12: a general 2-D array would hold tagged pointers. The loop order is the
;;       plain i/j/k, not the cache-friendly reordering the task says would be faster.
(declaim (optimize (speed 3) (safety 0) (debug 0)))

(defun main ()
  (let ((n 500)
        (a (make-array 250000 :element-type 'fixnum))
        (b (make-array 250000 :element-type 'fixnum))
        (c (make-array 250000 :element-type 'fixnum))
        (total 0))
    (declare (fixnum n total)
             (type (simple-array fixnum (*)) a b c))
    (dotimes (i n)
      (declare (fixnum i))
      (let ((row (* i n)))
        (declare (fixnum row))
        (dotimes (j n)
          (declare (fixnum j))
          (setf (aref a (+ row j)) (mod (+ i j) 7))
          (setf (aref b (+ row j)) (mod (* i j) 5)))))
    (dotimes (i n)
      (declare (fixnum i))
      (let ((row (* i n)))
        (declare (fixnum row))
        (dotimes (j n)
          (declare (fixnum j))
          (let ((s 0))
            (declare (fixnum s))
            (dotimes (k n)
              (declare (fixnum k))
              (incf s (* (aref a (+ row k)) (aref b (+ (* k n) j)))))
            (setf (aref c (+ row j)) s)))))
    (dotimes (k 250000)
      (declare (fixnum k))
      (incf total (aref c k)))
    (format t "~a~%" total)))

(main)
(ext:quit)
