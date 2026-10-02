;; task 01 branches — expected output: 33333334 13333333 7619048 45714285
;; build: ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) \
;;            (setf c::*cc* "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe" c::*ld* c::*cc*) \
;;            (si:setenv "INCLUDE" "C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared") \
;;            (si:setenv "LIB" "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64") \
;;            (compile-file "01_branches.lisp" :output-file "01_branches.fas") (ext:quit))"
;; run: ecl.exe --norc --eval "(load \"01_branches.fas\" :verbose nil)"
;; note: ECL's compile-file routes the C it generates through a C compiler, and falls back to
;;       its bytecode compiler without one. That fallback is silent and the loops then run
;;       5-10x slower, so the build points c::*cc* at the MSVC tree under tools/ and gives
;;       cl.exe the INCLUDE and LIB it needs; nothing of that is on PATH on this host.
;; note: the run line is `--eval "(load ... :verbose nil)"` and not `--load`, because --load
;;       writes ";;; Loading #P\"...\"" to stdout and each task prints one line and nothing else.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0))) plus fixnum declarations is what
;;       makes these loops tight; without them every step goes through generic arithmetic.
(declaim (optimize (speed 3) (safety 0) (debug 0)))

;; Four counters and one if/else chain, a hundred million times. The chain is `cond`, which
;; is Common Lisp's if/else-if, so the mispredicted branch shows up directly.
(defun main ()
  (let ((a 0) (b 0) (c 0) (d 0))
    (declare (fixnum a b c d))
    (dotimes (i 100000000)
      (declare (fixnum i))
      (cond ((= 0 (mod i 3)) (incf a))
            ((= 0 (mod i 5)) (incf b))
            ((= 0 (mod i 7)) (incf c))
            (t (incf d))))
    (format t "~a ~a ~a ~a~%" a b c d)))

(main)
(ext:quit)
