; task 09 fib_recursive — expected output: 102334155
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 09_fib_recursive.arc
; note: run from this directory (sources/arc). boot.rkt is given by absolute path so the host finds
;       its own libraries; the .arc file is named relative to the current directory, which is what
;       boot.rkt's command line does with its <file> argument.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run.
; note: the naive double recursion, about 331 million calls. There is no way to mark a function
;       no-inline in Arc and none is needed: `fib` is a global, so every one of those calls resolves
;       the name through the global namespace and coerces the value to 'fn before applying it. That
;       is the call path this task is meant to measure.

(def fib (n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

(prn (fib 40))
