;; task 15 file_write — expected output: 52428800
;; build: ecl.exe --norc --eval "(progn (require :cmp) (ext:install-c-compiler) \
;;            (setf c::*cc* "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe" c::*ld* c::*cc*) \
;;            (si:setenv "INCLUDE" "C:/stupidspeed/tools/ecl;C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/include;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/ucrt;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/um;C:/stupidspeed/tools/msvc/Windows Kits/10/Include/10.0.26100.0/shared") \
;;            (si:setenv "LIB" "C:/stupidspeed/tools/msvc/VC/Tools/MSVC/14.44.35207/lib/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/ucrt/x64;C:/stupidspeed/tools/msvc/Windows Kits/10/Lib/10.0.26100.0/um/x64") \
;;            (compile-file "15_file_write.lisp" :output-file "15_file_write.fas") (ext:quit))"
;; run: ecl.exe --norc --eval "(load \"15_file_write.fas\" :verbose nil)"
;; note: ECL's compile-file routes the C it generates through a C compiler, and falls back to
;;       its bytecode compiler without one. That fallback is silent and the loops then run
;;       5-10x slower, so the build points c::*cc* at the MSVC tree under tools/ and gives
;;       cl.exe the INCLUDE and LIB it needs; nothing of that is on PATH on this host.
;; note: the run line is `--eval "(load ... :verbose nil)"` and not `--load`, because --load
;;       writes ";;; Loading #P\"...\"" to stdout and each task prints one line and nothing else.
;; note: (declaim (optimize (speed 3) (safety 0) (debug 0))) plus fixnum declarations is what
;;       makes these loops tight; without them every step goes through generic arithmetic.
;; note: this row does reach a real fsync, which the SBCL row notes it cannot. Common Lisp has
;;       no standard fsync, but ECL has an FFI, so `commit` is a one-line ffi:c-inline of the
;;       CRT's _commit(fd) -- the Windows spelling of fsync -- applied to the descriptor from
;;       ext:file-stream-fd. That is why this file has to be compiled rather than loaded as
;;       source: ffi:c-inline is a compiler special form and the interpreter rejects it.
;; note: the 1 MiB buffer is written 50 times, then force-output flushes ECL's own buffer and
;;       _commit pushes it to the disk. No extra fsync on close.
(declaim (optimize (speed 3) (safety 0) (debug 0)))

;; _commit is the CRT's fsync: it flushes the descriptor's buffers to the operating system.
(defun commit (fd)
  (ffi:c-inline (fd) (:int) :int "_commit(#0)" :one-liner t))

(defun main ()
  (let ((buf (make-array 1048576 :element-type '(unsigned-byte 8))))
    (dotimes (i 1048576)
      (declare (fixnum i))
      (setf (aref buf i) (mod i 256)))
    (with-open-file (out "out.bin" :direction :output :if-exists :supersede
                                   :element-type '(unsigned-byte 8))
      (dotimes (i 50)
        (declare (fixnum i))
        (write-sequence buf out))
      (force-output out)
      (commit (ext:file-stream-fd out)))
    (format t "~a~%" (* 50 1048576))))

(main)
(ext:quit)
