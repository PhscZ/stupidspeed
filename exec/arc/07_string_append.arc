; task 07 string_append — expected output: 250000
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 07_string_append.arc
; note: run from this directory (sources/arc). boot.rkt is given by absolute path so the host finds
;       its own libraries; the .arc file is named relative to the current directory, which is what
;       boot.rkt's command line does with its <file> argument.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot is inside every
;       measured run.
; note: deliberately the plain quadratic append, and this is the row's slow cell. Arc strings are
;       Racket strings, which are immutable, so (+ text "x") is Racket's string-append: it allocates
;       a fresh string and copies the whole accumulator every time. 250000 appends copy about
;       3.1x10^10 bytes. No port, no string builder, no `string` with a list of pieces.
; note: this is the same shape and the same cost the Racket row's task 07 has, which RUN.md
;       records. Nothing here narrows it: the loop is Arc's `loop`/`recur` and the
;       append is Arc's `+`, which dispatches to string-append for two strings.

; Self-timing: t0 is read as the first thing the program's body does, and the elapsed
; milliseconds are written to stderr with Arc's own `ero` (which prints through (stderr))
; immediately before the answer goes to stdout with `prn`. The clock is the Racket host's
; current-inexact-milliseconds, reached through Arc's ($ ...) escape, so the bracketed region
; is this script's own work and stdout is unchanged.
(= t0 ($ (current-inexact-milliseconds)))

(with (text "")
  (loop (i 0)
    (when (< i 250000)
      (= text (+ text "x"))
      (recur (+ i 1))))
  (ero "TIME_MS=" (- ($ (current-inexact-milliseconds)) t0))
  (prn (len text)))
