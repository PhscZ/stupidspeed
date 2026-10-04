; task 13 matrix_mul — expected output: 599995000
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 13_matrix_mul.arc
; note: run from this directory (sources/arc). boot.rkt is given by absolute path so the host finds
;       its own libraries; the .arc file is named relative to the current directory, which is what
;       boot.rkt's command line does with its <file> argument.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run.
; note: the plain i, j, k triple loop in that order, on flat row-major `vec`s, so the k loop walks a
;       column of B. Reordering would be faster, which is the point.
; note: the element accesses go through Arc's own ($ ...) escape, which is the language's documented
;       way to reach its host; arc.arc itself uses it for the vector case of `len`. Without it the
;       generic reference path costs about 12 us per element (measured), and this loop makes 125
;       million of them. A `,` inside `$` splices an Arc expression back into the Racket form, so
;       `,(+ (* r n) k)` is computed by Arc. The loops are Arc's own `loop`/`recur`, and the index
;       arithmetic, the multiply-add and the two mods are Arc's own `+`, `*`, `-` and `mod`.

; Self-timing: t0 is read as the first thing the program's body does, and the elapsed
; milliseconds are written to stderr with Arc's own `ero` (which prints through (stderr))
; immediately before the answer goes to stdout with `prn`. The clock is the Racket host's
; current-inexact-milliseconds, reached through Arc's ($ ...) escape, so the bracketed region
; is this script's own work and stdout is unchanged.
(= t0 ($ (current-inexact-milliseconds)))

(with (n 500
       size 250000)
  (= a (vec size 0)
     b (vec size 0)
     c (vec size 0))

  (loop (i 0)
    (when (< i n)
      (loop (j 0)
        (when (< j n)
          (with (idx (+ (* i n) j))
            ($ (vector-set! ,a ,idx ,(mod (+ i j) 7)))
            ($ (vector-set! ,b ,idx ,(mod (* i j) 5))))
          (recur (+ j 1))))
      (recur (+ i 1))))

  (loop (r 0)
    (when (< r n)
      (loop (col 0)
        (when (< col n)
          (with (sum 0)
            (loop (k 0)
              (when (< k n)
                (= sum (+ sum (* ($ (vector-ref ,a ,(+ (* r n) k)))
                                 ($ (vector-ref ,b ,(+ (* k n) col))))))
                (recur (+ k 1))))
            ($ (vector-set! ,c ,(+ (* r n) col) ,sum)))
          (recur (+ col 1))))
      (recur (+ r 1))))

  (with (total 0)
    (loop (e 0)
      (when (< e size)
        (= total (+ total ($ (vector-ref ,c ,e))))
        (recur (+ e 1))))
    (ero "TIME_MS=" (- ($ (current-inexact-milliseconds)) t0))
    (prn total)))
