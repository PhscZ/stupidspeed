; task 07 string_append — expected output: 1000000
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 07_string_append.arc
; note: run from this directory (sources/arc). boot.rkt is given by absolute path so the host finds
;       its own libraries; the .arc file is named relative to the current directory, which is what
;       boot.rkt's command line does with its <file> argument.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run.
; note: deliberately the plain quadratic append, and this is the row's slow cell. Arc strings are
;       Racket strings, which are immutable, so (+ text "x") is Racket's string-append: it allocates
;       a fresh string and copies the whole accumulator every time. A million appends copy about
;       5x10^11 bytes. No port, no string builder, no `string` with a list of pieces.
; note: this is the same shape and the same cost the Racket row's task 07 has, which RUN.md measures
;       at about 19 minutes a run. Nothing here narrows it: the loop is Arc's `loop`/`recur` and the
;       append is Arc's `+`, which dispatches to string-append for two strings.

(with (text "")
  (loop (i 0)
    (when (< i 1000000)
      (= text (+ text "x"))
      (recur (+ i 1))))
  (prn (len text)))
