; task 08 average — expected output: 0.498046875
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 08_average.arc
; note: run from this directory (sources/arc). boot.rkt is given by absolute path so the host finds
;       its own libraries; the .arc file is named relative to the current directory, which is what
;       boot.rkt's command line does with its <file> argument.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run.
; note: 256.0 is read as an inexact real, so (/ (mod i 256) 256.0) is an inexact division and the
;       total stays inexact. Arc's `/` is Racket's `/`; the exact integer in the numerator is what
;       makes the result inexact here rather than an exact rational.
; note: every reading is a multiple of 1/256 and the total is well under 2^53, so the sum is exact
;       and the printed digits do not depend on the order the numbers are added in.
; note: `prn` displays through Racket's display, which prints 0.498046875 rather than the shortest
;       round-tripping form a language with a different float printer would choose.

(with (total 0.0)
  (loop (i 0)
    (when (< i 100000000)
      (= total (+ total (/ (mod i 256) 256.0)))
      (recur (+ i 1))))
  (prn (/ total 100000000)))
