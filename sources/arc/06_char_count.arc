; task 06 char_count — expected output: 10000000
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 06_char_count.arc
; note: run from this directory (sources/arc). boot.rkt is given by absolute path so the host finds
;       its own libraries; the .arc file is named relative to the current directory, which is what
;       boot.rkt's command line does with its <file> argument.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run.
; note: the 100 MB text is built by doubling the ten-character block inside one preallocated mutable
;       string, so the build is O(log n) copies rather than a hundred million appends; the last
;       doubling is clamped to the end of the string. The build is not part of the scan.
; note: the per-character read goes through Arc's own ($ ...) escape, which is the language's
;       documented way to reach its host; arc.arc itself uses it for the vector case of `len`.
;       Without it the generic reference path costs about 11 us per character (measured: 10.9 s for
;       a million characters against 0.6 s for the escape), and over a hundred million characters
;       that would be the entire cell. A `,` inside `$` splices an Arc expression back into the
;       Racket form, so `,i` is the loop variable and `,text` is the local string.

(with (n 100000000)
  (= text (newstring n #\a))
  ($ (string-copy! ,text 0 "abcdefghij"))

  (loop (k 10)
    (when (< k n)
      ($ (string-copy! ,text ,k ,text 0 ,(min k (- n k))))
      (recur (* 2 k))))

  (with (count 0)
    (loop (i 0)
      (when (< i n)
        (if (is ($ (string-ref ,text ,i)) #\h) (++ count))
        (recur (+ i 1))))
    (prn count)))
