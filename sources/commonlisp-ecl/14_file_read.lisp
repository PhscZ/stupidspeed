;; task 14 file_read — expected output: 2389704704
;; build: ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) \
;;            (setf c::*cc* "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe" c::*ld* c::*cc*) \
;;            (si:setenv "INCLUDE" "C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared") \
;;            (si:setenv "LIB" "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64") \
;;            (compile-file "14_file_read.lisp" :output-file "14_file_read.fas") (ext:quit))"
;; run: ecl.exe --norc --eval "(load \"14_file_read.fas\" :verbose nil)"
;; note: ECL's compile-file routes the C it generates through a C compiler, and falls back to
;;       its bytecode compiler without one. That fallback is silent and the loops then run
;;       5-10x slower, so the build points c::*cc* at the MSVC tree under tools/ and gives
;;       cl.exe the INCLUDE and LIB it needs; nothing of that is on PATH on this host.
;; note: the run line is `--eval "(load ... :verbose nil)"` and not `--load`, because --load
;;       writes ";;; Loading #P\"...\"" to stdout and each task prints one line and nothing else.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0))) plus fixnum declarations is what
;;       makes these loops tight; without them every step goes through generic arithmetic.
;; note: data.bin is opened with :element-type '(unsigned-byte 8), so read-sequence fills an
;;       unboxed 1 MiB octet buffer and the scan is a byte loop over it. The total is
;;       50 MiB * 127.5 = 6684672000, below 2^61, so it stays a fixnum and no bignum is
;;       allocated inside the loop. The final mod 4294967296 is the task's own wraparound.
(declaim (optimize (speed 3) (safety 0) (debug 0)))

(defun main ()
  (let ((total 0))
    (declare (fixnum total))
    (with-open-file (in "data.bin" :direction :input :element-type '(unsigned-byte 8))
      (let ((buf (make-array 1048576 :element-type '(unsigned-byte 8))))
        (loop for n fixnum = (read-sequence buf in)
              while (> n 0)
              do (dotimes (i n)
                   (declare (fixnum i))
                   (incf total (aref buf i))))))
    (format t "~a~%" (mod total 4294967296))))

(main)
(ext:quit)
