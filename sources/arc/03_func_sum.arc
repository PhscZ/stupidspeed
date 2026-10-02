; task 03 func_sum — expected output: 100000000
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 03_func_sum.arc
; note: run from this directory (sources/arc). boot.rkt is given by absolute path so the host finds
;       its own libraries; the .arc file is named relative to the current directory, which is what
;       boot.rkt's command line does with its <file> argument.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run.
; note: the function needs no file of its own and there is no no-inline marker to apply. Arc's
;       compiler emits a call for every Arc call and Racket's own compiler is not given the whole
;       picture, so the hundred million calls really happen; the counter in the loop keeps the
;       result live in any case.
; note: `add-one` is a global, so each call resolves it through the global namespace and then
;       coerces the value to 'fn before applying it. That coercion is part of Arc's call cost and
;       is deliberately left in rather than hoisted, because this task measures the call path.

(def add-one (n)
  (+ n 1))

(with (value 0)
  (loop (i 0)
    (when (< i 100000000)
      (= value (add-one value))
      (recur (+ i 1))))
  (prn value))
