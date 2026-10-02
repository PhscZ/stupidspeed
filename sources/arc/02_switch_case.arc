; task 02 switch_case — expected output: 7500000075000000
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 02_switch_case.arc
; note: run from this directory (sources/arc). boot.rkt is given by absolute path so the host finds
;       its own libraries; the .arc file is named relative to the current directory, which is what
;       boot.rkt's command line does with its <file> argument.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run.
; note: `case` is Arc's switch. It macro-expands to a chain of `is` tests against the quoted keys,
;       so there is no jump table to compile here and no compiler to build one -- the four-way
;       decision costs four comparisons in the worst case, exactly like the if/else chain in task 01.
; note: `acc` is a local of the `with`, so the assignment compiles to a plain set! rather than to
;       Arc's global setter; the loop is Arc's `loop`/`recur` rather than `for`, for the reason
;       task 01 records.

; The same four-way decision as task 01 with i mod 4 as the selector.
(with (acc 0)
  (loop (i 0)
    (when (< i 100000000)
      (= acc (+ acc (case (mod i 4)
                      0 1
                      1 i
                      2 (* 2 i)
                      3 (* 3 i))))
      (recur (+ i 1))))
  (prn acc))
