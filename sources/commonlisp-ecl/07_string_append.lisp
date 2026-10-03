;; task 07 string_append — expected output: 250000
;; build: ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) \
;;            (setf c::*cc* "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe" c::*ld* c::*cc*) \
;;            (si:setenv "INCLUDE" "C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared") \
;;            (si:setenv "LIB" "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64") \
;;            (compile-file "07_string_append.lisp" :output-file "07_string_append.fas") (ext:quit))"
;; run: ecl.exe --norc --eval "(load \"07_string_append.fas\" :verbose nil)"
;; note: ECL's compile-file routes the C it generates through a C compiler, and falls back to
;;       its bytecode compiler without one. That fallback is silent and the loops then run
;;       5-10x slower, so the build points c::*cc* at the MSVC tree under tools/ and gives
;;       cl.exe the INCLUDE and LIB it needs; nothing of that is on PATH on this host.
;; note: the run line is `--eval "(load ... :verbose nil)"` and not `--load`, because --load
;;       writes ";;; Loading #P\"...\"" to stdout and each task prints one line and nothing else.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0))) plus fixnum declarations is what
;;       makes these loops tight; without them every step goes through generic arithmetic.
;; note: this file spells the append out -- allocate a base-string one longer and copy -- rather
;;       than calling (concatenate 'string text "x") the way the SBCL row does, because ECL's
;;       concatenate goes through the generic sequence protocol and is much slower. The
;;       spelled-out form is the same operation concatenate performs (allocate a result of the
;;       combined length, copy the inputs) but it is still the quadratic copy this task is
;;       designed to measure. No adjustable vector and no fill pointer, either of which would
;;       make this linear and hide the whole point.
;; note: the 250000 iterations also allocate tens of gigabytes of garbage, which is what the
;;       Boehm GC (:BOEHM-GC is in *features*) spends the time on; SBCL's bump allocator does
;;       the same loop in seconds.
(declaim (optimize (speed 3) (safety 0) (debug 0)))

(defun main ()
  (let ((text ""))
    (declare (type simple-base-string text))
    (dotimes (i 250000)
      (declare (fixnum i))
      (let* ((len (length text))
             (new (make-string (1+ len) :element-type 'base-char)))
        (replace new text)
        (setf (char new len) #\x)
        (setf text new)))
    (format t "~a~%" (length text))))

(main)
(ext:quit)
