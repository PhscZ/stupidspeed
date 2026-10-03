;; task 07 string_append — expected output: 250000
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 07_string_append.ss
;; note: plain string concatenation 250000 times. Chez strings are fixed-length and
;;       immutable, so every append allocates a new string and copies the old one, which is
;;       the same quadratic copy the C row's realloc plus strcat does. Deliberately no string
;;       port, no string builder and no growable string: this cell is meant to measure the
;;       quadratic cost, exactly as the Racket row's does.

;; text = text + "x", 250000 times.
(let loop ([i 0] [text ""])
  (if (fx= i 250000)
      (begin (display (string-length text)) (newline))
      (loop (fx+ i 1) (string-append text "x"))))
