; task 01 branches — expected output: 33333334 13333333 7619048 45714285
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 01_branches.arc
; note: run from this directory (sources/arc). boot.rkt is given by absolute path so the host finds
;       its own libraries; the .arc file is named relative to the current directory, which is what
;       boot.rkt's command line does with its <file> argument.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run. Every row on an interpreter has the same shape.
; note: the four counters are locals of a `with`, not globals. Arc compiles an assignment to a
;       defined global as a call to that global's setter procedure -- ac.rkt's `ac-set1` emits
;       `(_name value)` for a defined global and a plain `(set! name value)` for a lexically bound
;       one -- so globals would add a call, plus a temporary binding, to a loop whose whole content
;       is four increments.
; note: the loop is Arc's own `loop`/`recur` rather than `for`/`up`. `for` wraps every iteration
;       in an escape continuation (it is written on `point`), which is measurable here: 1.5 us per
;       iteration against 0.8 us. `loop` is the plain named-let form and is what arc.arc itself uses
;       for its hot list walks.

; Self-timing: t0 is read as the first thing the program's body does, and the elapsed
; milliseconds are written to stderr with Arc's own `ero` (which prints through (stderr))
; immediately before the answer goes to stdout with `prn`. The clock is the Racket host's
; current-inexact-milliseconds, reached through Arc's ($ ...) escape, so the bracketed region
; is this script's own work and stdout is unchanged.
(= t0 ($ (current-inexact-milliseconds)))

; One if/else chain over a hundred million values.
(with (a 0 b 0 c 0 d 0)
  (loop (i 0)
    (when (< i 100000000)
      (if (is 0 (mod i 3))
          (++ a)
          (is 0 (mod i 5))
          (++ b)
          (is 0 (mod i 7))
          (++ c)
          (++ d))
      (recur (+ i 1))))
  (ero "TIME_MS=" (- ($ (current-inexact-milliseconds)) t0))
  (prn a " " b " " c " " d))
