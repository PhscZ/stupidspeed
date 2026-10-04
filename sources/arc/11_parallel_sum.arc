; task 11 parallel_sum — expected output: 7500000075000000
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 11_parallel_sum.arc
; note: run from this directory (sources/arc). boot.rkt is given by absolute path so the host finds
;       its own libraries; the .arc file is named relative to the current directory, which is what
;       boot.rkt's command line does with its <file> argument.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run.
; note: this is a real-parallelism cell, not a correct-answer-no-speedup one. Racket's plain `thread`
;       is green -- cooperative, on one OS thread -- and `future` silently serialises as soon as its
;       body does anything blocking. The parallel route is `(thread thunk #:pool 'own #:keep
;       'results)`, which runs the thunk on its own OS thread with the heap shared, and `thread-wait`
;       then hands back what the thunk returned; that needs Racket 8.18 or later and this is 9.3.
; note: Arc's own `thread` macro and its `new-thread` are bound to the plain one-argument Racket
;       `thread` (see `(xdef new-thread thread)` and the `thread` macro in arc.arc), so they cannot
;       pass `#:pool`; a row that used them would be green and would print the right answer with no
;       speedup. The four workers are therefore started through Arc's own ($ ...) escape, which is
;       the language's documented way to reach its host and is what arc.arc itself uses for
;       `vector-length`, `string-set!` and the other primitives Arc does not re-export. A `,` inside
;       `$` splices an Arc expression back into the Racket form.
; note: `thread-wait` is not one of the names Arc re-exports either, so the join goes through the
;       same escape. Each worker returns its own partial sum and the main thread adds the four, so
;       the workers share no mutable state at all and no `atomic` lock is taken inside a worker.
; note: measured on this host, 4 x 25000000: one worker alone 51.6 s, the four on `#:pool 'own`
;       88.3 s, the same four calls sequentially 170.6 s, and the four on green threads 196.1 s.
;       That is about 1.9x over the serial form and the four cores are genuinely busy.

; Self-timing: t0 is read as the first thing the program's body does, and the elapsed
; milliseconds are written to stderr with Arc's own `ero` (which prints through (stderr))
; immediately before the answer goes to stdout with `prn`. The clock is the Racket host's
; current-inexact-milliseconds, reached through Arc's ($ ...) escape, so the bracketed region
; is this script's own work and stdout is unchanged.
(= t0 ($ (current-inexact-milliseconds)))

; worker t covers [t*25000000, (t+1)*25000000).
(def work (t)
  (with (acc 0)
    (loop (i (* t 25000000))
      (when (< i (* (+ t 1) 25000000))
        (= acc (+ acc (case (mod i 4)
                        0 1
                        1 i
                        2 (* 2 i)
                        3 (* 3 i))))
        (recur (+ i 1))))
    acc))

(with (threads (map (fn (t)
                      ($ (thread ,(fn () (work t)) #:pool 'own #:keep 'results)))
                    '(0 1 2 3)))
  (with (total 0)
    (each th threads
      (= total (+ total ($ (thread-wait ,th)))))
    (ero "TIME_MS=" (- ($ (current-inexact-milliseconds)) t0))
    (prn total)))
