;; task 15 file_write — expected output: 52428800
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 15_file_write.ss
;; note: the 1 MiB buffer is written 50 times to out.bin and then flushed and closed. Chez's
;;       standard library exposes flush-output-port but no fsync on a file port, so the
;;       deviation is flush plus close -- the same one the Tcl, D, Julia, Nim, Dart, Pascal,
;;       Racket, COBOL and Dolphin rows note. Nothing calls the Windows _commit.
;; note: the port is opened block-buffered, so the 50 put-bytevector calls go into the port
;;       buffer and the kernel sees the 1 MiB writes.

(define len 1048576)
(define buf (make-bytevector len 0))

(let fill ([i 0])
  (when (fx< i len)
    (bytevector-u8-set! buf i (fxmod i 256))
    (fill (fx+ i 1))))

(define out (open-file-output-port "out.bin" (file-options no-fail) (buffer-mode block)))

(let loop ([i 0])
  (when (fx< i 50)
    (put-bytevector out buf)
    (loop (fx+ i 1))))

(flush-output-port out)
(close-port out)

(display (* 50 len))
(newline)
