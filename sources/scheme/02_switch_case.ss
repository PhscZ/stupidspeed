;; task 02 switch_case — expected output: 7500000075000000
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 02_switch_case.ss
;; note: `case` is Scheme's switch. Chez compiles a case whose keys are the fixnums 0..3 into
;;       a jump table, so this is the same four-way dispatch the C row's `switch` gets.
;; note: the accumulator reaches 7500000075000000, which is about 7.5e15. Chez's fixnums are
;;       61 bits wide on x86-64, so the whole sum stays a fixnum and fx+ is exact. A wider
;;       value would promote to a bignum and fx+ would signal an error instead, which is why
;;       the bound is checked rather than assumed.

;; case on (fxmod i 4) with a single accumulator carried as a named-let argument.
(let loop ([i 0] [acc 0])
  (if (fx= i 100000000)
      (begin (display acc) (newline))
      (loop (fx+ i 1)
            (fx+ acc (case (fxmod i 4)
                       [(0) 1]
                       [(1) i]
                       [(2) (fx* 2 i)]
                       [else (fx* 3 i)])))))
