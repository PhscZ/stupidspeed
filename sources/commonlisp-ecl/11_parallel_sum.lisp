;; task 11 parallel_sum — expected output: 7500000075000000
;; build: ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) \
;;            (setf c::*cc* "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe" c::*ld* c::*cc*) \
;;            (si:setenv "INCLUDE" "C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared") \
;;            (si:setenv "LIB" "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64") \
;;            (compile-file "11_parallel_sum.lisp" :output-file "11_parallel_sum.fas") (ext:quit))"
;; run: ecl.exe --norc --eval "(load \"11_parallel_sum.fas\" :verbose nil)"
;; note: ECL's compile-file routes the C it generates through a C compiler, and falls back to
;;       its bytecode compiler without one. That fallback is silent and the loops then run
;;       5-10x slower, so the build points c::*cc* at the MSVC tree under tools/ and gives
;;       cl.exe the INCLUDE and LIB it needs; nothing of that is on PATH on this host.
;; note: the run line is `--eval "(load ... :verbose nil)"` and not `--load`, because --load
;;       writes ";;; Loading #P\"...\"" to stdout and each task prints one line and nothing else.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0))) plus fixnum declarations is what
;;       makes these loops tight; without them every step goes through generic arithmetic.
;; note: this build of ECL has the mp package and :THREADS is in *features*, so the four
;;       workers are mp:process-run-function processes over Win32 threads -- real OS threads,
;;       one per worker, with no global lock. mp:process-join is the join. Each worker owns a
;;       fixed quarter of the range and stores its partial into a slot of `results`, so no
;;       locking is needed and the answer does not depend on scheduling.
;; note: the worker index is bound through a LET rather than closed over directly. A plain
;;       (dotimes (n 4) ... (lambda () (work n))) would capture the one binding and all four
;;       workers would read whatever it ended up as, which is the classic closure-capture trap.
;;       The index variable is not called `t`: T is a defined constant in Common Lisp.
(declaim (optimize (speed 3) (safety 0) (debug 0)))

;; work does task 02's switch over one fixed quarter of the range.
(defun work (idx)
  (declare (fixnum idx))
  (let ((acc 0))
    (declare (fixnum acc))
    (loop for i fixnum from (* idx 25000000) below (* (+ idx 1) 25000000) do
      (incf acc (case (mod i 4)
                  (0 1)
                  (1 i)
                  (2 (* 2 i))
                  (t (* 3 i)))))
    acc))

(defun main ()
  (let ((threads '())
        (results (make-array 4)))
    (dotimes (n 4)
      (declare (fixnum n))
      (let ((id n))
        (push (mp:process-run-function (format nil "w~a" id)
                                       (lambda () (setf (aref results id) (work id))))
              threads)))
    (dolist (th threads)
      (mp:process-join th))
    (let ((total 0))
      (declare (fixnum total))
      (dotimes (k 4)
        (declare (fixnum k))
        (incf total (aref results k)))
      (format t "~a~%" total))))

(main)
(ext:quit)
