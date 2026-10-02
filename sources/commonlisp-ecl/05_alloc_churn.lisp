;; task 05 alloc_churn — expected output: 1274991808
;; build: ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) \
;;            (setf c::*cc* "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe" c::*ld* c::*cc*) \
;;            (si:setenv "INCLUDE" "C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared") \
;;            (si:setenv "LIB" "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64") \
;;            (compile-file "05_alloc_churn.lisp" :output-file "05_alloc_churn.fas") (ext:quit))"
;; run: ecl.exe --norc --eval "(load \"05_alloc_churn.fas\" :verbose nil)"
;; note: ECL's compile-file routes the C it generates through a C compiler, and falls back to
;;       its bytecode compiler without one. That fallback is silent and the loops then run
;;       5-10x slower, so the build points c::*cc* at the MSVC tree under tools/ and gives
;;       cl.exe the INCLUDE and LIB it needs; nothing of that is on PATH on this host.
;; note: the run line is `--eval "(load ... :verbose nil)"` and not `--load`, because --load
;;       writes ";;; Loading #P\"...\"" to stdout and each task prints one line and nothing else.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0))) plus fixnum declarations is what
;;       makes these loops tight; without them every step goes through generic arithmetic.
;; note: ECL's runtime is Boehm GC (:BOEHM-GC is in *features*), and the 64-byte buffer is a
;;       (simple-array (unsigned-byte 8) (64)) -- a real heap object, not a displaced pointer.
;;       Storing it into `slots` keeps it reachable and drops the buffer it replaces, so the
;;       allocation is live at every iteration and ten million of them become garbage.
(declaim (optimize (speed 3) (safety 0) (debug 0)))

(defun main ()
  (let ((slots (make-array 256))
        (total 0))
    (declare (fixnum total))
    (dotimes (i 10000000)
      (declare (fixnum i))
      (let ((buf (make-array 64 :element-type '(unsigned-byte 8))))
        (setf (aref buf 0) (mod i 256))
        (incf total (aref buf 0))
        (setf (aref slots (mod i 256)) buf)))
    (format t "~a~%" total)))

(main)
(ext:quit)
