; task 04 array_sum — expected output: 499999500000
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 04_array_sum.arc
; note: run from this directory (sources/arc). boot.rkt is given by absolute path so the host finds
;       its own libraries; the .arc file is named relative to the current directory, which is what
;       boot.rkt's command line does with its <file> argument.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run.
; note: `vec` is Arc's packed array -- Racket's make-vector underneath -- so the fill and the read
;       walk one contiguous million-element block, and they are two separate passes so the fill is
;       not inside the read loop.
; note: the element accesses go through Arc's own ($ ...) escape, which is the language's documented
;       way to reach its host; arc.arc itself uses it for the vector case of `len`, `(defextend len
;       (x) (isa x 'vector) ($.vector-length x))`. Without it the generic reference path costs about
;       12 us per element (measured: 12.2 s for a million reads against 0.5 s for the escape), which
;       would make this cell a measurement of Arc's dispatch rather than of the array. A `,` inside
;       `$` splices an Arc expression back into the Racket form, so `,i` is the loop variable and
;       `,arr` is the local array.

; Self-timing: t0 is read as the first thing the program's body does, and the elapsed
; milliseconds are written to stderr with Arc's own `ero` (which prints through (stderr))
; immediately before the answer goes to stdout with `prn`. The clock is the Racket host's
; current-inexact-milliseconds, reached through Arc's ($ ...) escape, so the bracketed region
; is this script's own work and stdout is unchanged.
(= t0 ($ (current-inexact-milliseconds)))

(with (n 1000000)
  (= arr (vec n 0))

  (loop (i 0)
    (when (< i n)
      ($ (vector-set! ,arr ,i ,i))
      (recur (+ i 1))))

  (with (total 0)
    (loop (i 0)
      (when (< i n)
        (= total (+ total ($ (vector-ref ,arr ,i))))
        (recur (+ i 1))))
    (ero "TIME_MS=" (- ($ (current-inexact-milliseconds)) t0))
    (prn total)))
