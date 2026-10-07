; task 12 matrix_add — expected output: 999000000
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 12_matrix_add.arc
; note: run from this directory (sources/arc). boot.rkt is given by absolute path so the host finds
;       its own libraries; the .arc file is named relative to the current directory, which is what
;       boot.rkt's command line does with its <file> argument.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run.
; note: A, B and C are three 1000x1000 `vec`s -- flat Racket vectors of a million elements each --
;       which is the same row-major layout the C rows use, and the eight megabytes per array are
;       what make this a memory-bandwidth measurement rather than a compute one.
; note: the element accesses go through Arc's own ($ ...) escape, which is the language's documented
;       way to reach its host; arc.arc itself uses it for the vector case of `len`. Without it the
;       generic reference path costs about 12 us per element (measured), and this task makes three
;       million of them. A `,` inside `$` splices an Arc expression back into the Racket form, so
;       `,idx` is the local index and `,(+ i j)` is computed by Arc. The loops are Arc's own
;       `loop`/`recur`.

; Self-timing: t0 is read as the first thing the program's body does, and the elapsed
; milliseconds are written to stderr with Arc's own `ero` (which prints through (stderr))
; immediately before the answer goes to stdout with `prn`. The clock is the Racket host's
; current-inexact-milliseconds, reached through Arc's ($ ...) escape, so the bracketed region
; is this script's own work and stdout is unchanged.
(= t0 ($ (current-inexact-milliseconds)))

(with (n 1000
       size 1000000)
  (= a (vec size 0)
     b (vec size 0)
     c (vec size 0))

  (loop (i 0)
    (when (< i n)
      (loop (j 0)
        (when (< j n)
          (with (idx (+ (* i n) j))
            ($ (vector-set! ,a ,idx ,(+ i j)))
            ($ (vector-set! ,b ,idx ,(- i j))))
          (recur (+ j 1))))
      (recur (+ i 1))))

  (loop (e 0)
    (when (< e size)
      ($ (vector-set! ,c ,e ,(+ ($ (vector-ref ,a ,e)) ($ (vector-ref ,b ,e)))))
      (recur (+ e 1))))

  (with (total 0)
    (loop (e 0)
      (when (< e size)
        (= total (+ total ($ (vector-ref ,c ,e))))
        (recur (+ e 1))))
    (ero "TIME_MS=" (- ($ (current-inexact-milliseconds)) t0))
    (prn total)))
