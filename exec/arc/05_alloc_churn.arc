; task 05 alloc_churn — expected output: 1274991808
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 05_alloc_churn.arc
; note: run from this directory (sources/arc). boot.rkt is given by absolute path so the host finds
;       its own libraries; the .arc file is named relative to the current directory, which is what
;       boot.rkt's command line does with its <file> argument.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run.
; note: `newstring` is Arc's name for Racket's make-string, so each of the ten million iterations
;       allocates a fresh 64-character mutable string, and the store into `slots` is what keeps the
;       newest 256 of them reachable so that the replaced ones become garbage.
; note: the byte write, the byte read and the slot store go through Arc's own ($ ...) escape, which
;       is the language's documented way to reach its host; arc.arc itself uses it for the vector
;       case of `len`. Without it the generic reference path costs about 12 us per element
;       (measured), which over ten million accesses would be the whole task instead of the
;       allocation, the store and the collector. A `,` inside `$` splices an Arc expression back
;       into the Racket form; `integer->char` and `modulo` are the host's own names and are left
;       alone.

; Self-timing: t0 is read as the first thing the program's body does, and the elapsed
; milliseconds are written to stderr with Arc's own `ero` (which prints through (stderr))
; immediately before the answer goes to stdout with `prn`. The clock is the Racket host's
; current-inexact-milliseconds, reached through Arc's ($ ...) escape, so the bracketed region
; is this script's own work and stdout is unchanged.
(= t0 ($ (current-inexact-milliseconds)))

(with (slots (vec 256 nil) total 0)
  (loop (i 0)
    (when (< i 10000000)
      (= buf (newstring 64 #\space))
      ($ (string-set! ,buf 0 (integer->char (modulo ,i 256))))
      (= total (+ total ($ (char->integer (string-ref ,buf 0)))))
      ($ (vector-set! ,slots (modulo ,i 256) ,buf))
      (recur (+ i 1))))
  (ero "TIME_MS=" (- ($ (current-inexact-milliseconds)) t0))
  (prn total))
