; task 10 pi — expected output: 4470
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 10_pi.arc
; note: run from this directory (sources/arc). boot.rkt is given by absolute path so the host finds
;       its own libraries; the .arc file is named relative to the current directory, which is what
;       boot.rkt's command line does with its <file> argument.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run.
; note: Arc has no bignum library of its own, but its arithmetic is Racket's arithmetic: (+ 1 n) and
;       (* q 10) promote through the fixnum range into Racket's exact arbitrary-precision integers,
;       and Arc's own `exact` and `int` report those values as ints. So this row does NOT hand-roll
;       base-1e9 limbs; it is one of the rows that takes the built-in route.
; note: the one operation Arc does not expose is integer division. Arc's `/` is Racket's `/`, which
;       on two exact integers yields an exact rational rather than a quotient, so the two divisions
;       the spigot needs go through Arc's own ($ ...) escape to Racket's `quotient`. That escape is
;       the language's documented way to call its host and arc.arc itself uses it for the primitives
;       Arc does not re-export; it is the only place this file reaches into Racket.
; note: the spigot's `t` is called `tt` here. Arc refuses any assignment to the name `t` -- the truth
;       literal is not rebindable, not even lexically, and `(= t ...)` stops the file with "Can't
;       rebind t". The renaming is forced by the language and changes nothing else.

; Gibbons' unbounded spigot, the same loop as every other row. Only the sum of the 1000 digits is
; printed. q and r grow to roughly 16000 limbs; n is always a single digit.
; Self-timing: t0 is read as the first thing the program's body does, and the elapsed
; milliseconds are written to stderr with Arc's own `ero` (which prints through (stderr))
; immediately before the answer goes to stdout with `prn`. The clock is the Racket host's
; current-inexact-milliseconds, reached through Arc's ($ ...) escape, so the bracketed region
; is this script's own work and stdout is unchanged.
(= t0 ($ (current-inexact-milliseconds)))

(with (q 1 r 0 tt 1 k 1 l 3 n 3 produced 0 total 0)
  (loop ()
    (when (< produced 1000)
      (with (u (+ (* 4 q) r)
             v (* (+ n 1) tt))
        (if (< u v)
            ; n is settled: emit it and advance
            (withs (u2 (* 10 (+ (* 3 q) r))
                    r2 (* 10 (- r (* n tt)))
                    n2 (- ($ (quotient ,u2 ,tt)) (* 10 n)))
              ; total is assigned before n, so it still reads the n that was just emitted
              (= total (+ total n)
                 q (* 10 q)
                 r r2
                 n n2
                 produced (+ produced 1)))
            ; not settled: widen the state by one more term
            (withs (u3 (+ (* q (+ 1 (* 7 k))) (* r l))
                    r2 (* (+ (* 2 q) r) l)
                    n2 ($ (quotient ,u3 ,(* tt l))))
              (= q (* q k)
                 r r2
                 tt (* tt l)
                 k (+ k 1)
                 l (+ l 2)
                 n n2)))
        (recur))))
  (ero "TIME_MS=" (- ($ (current-inexact-milliseconds)) t0))
  (prn total))
