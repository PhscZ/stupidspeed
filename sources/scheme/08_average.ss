;; task 08 average — expected output: 0.498046875
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 08_average.ss
;; note: the accumulator is a flonum and the arithmetic is the flonum-specific `fl` family
;;       (fl+, fl/), which is Chez's unboxed double path. Each reading is a multiple of
;;       1/256, so it is exact in binary, and the total stays well under 2^53; the sum is
;;       therefore exact and the digits do not depend on the order of addition.
;; note: Chez prints a flonum with the shortest representation that reads back to the same
;;       double, so display prints 0.498046875 and not a longer expansion.

(let loop ([i 0] [total 0.0])
  (if (fx= i 100000000)
      (begin (display (fl/ total 100000000.0)) (newline))
      (loop (fx+ i 1)
            (fl+ total (fl/ (fixnum->flonum (fxmod i 256)) 256.0)))))
