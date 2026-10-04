; task 15 file_write — expected output: 52428800
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 15_file_write.arc
; note: run from this directory (sources/arc); out.bin is created there. The .arc file is named
;       relative to that directory; boot.rkt is given by absolute path so the host finds its own
;       libraries.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run.
; note: the 1 MiB buffer is written 50 times through Arc's `outfile` (Racket's open-output-file), so
;       it is one write call per megabyte and not one per byte. Arc's byte-vector type is a list of
;       byte values, so the buffer itself is made and filled through Arc's own ($ ...) escape --
;       the language's documented way to reach its host, which arc.arc uses for the vector case of
;       `len`. A `,` inside `$` splices an Arc expression back into the Racket form.
; note: Racket exposes no fsync on a file port, so the flush is flush-output plus close, the same
;       deviation the Racket, Tcl, D, Julia, Nim, Dart, Pascal, COBOL and Dolphin rows record. Arc
;       flushes after every write unless the `explicit-flush` declaration is set, which it is not.

; Self-timing: t0 is read as the first thing the program's body does, and the elapsed
; milliseconds are written to stderr with Arc's own `ero` (which prints through (stderr))
; immediately before the answer goes to stdout with `prn`. The clock is the Racket host's
; current-inexact-milliseconds, reached through Arc's ($ ...) escape, so the bracketed region
; is this script's own work and stdout is unchanged.
(= t0 ($ (current-inexact-milliseconds)))

(with (len 1048576
       passes 50)
  (= buf ($ (make-bytes ,len 0)))
  (loop (i 0)
    (when (< i len)
      ($ (bytes-set! ,buf ,i ,(mod i 256)))
      (recur (+ i 1))))

  (= out (outfile "out.bin"))
  (loop (pass 0)
    (when (< pass passes)
      ($ (write-bytes ,buf ,out))
      (recur (+ pass 1))))
  ($ (flush-output ,out))
  (close out)

  (ero "TIME_MS=" (- ($ (current-inexact-milliseconds)) t0))
  (prn (* passes len)))
