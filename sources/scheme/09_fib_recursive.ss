;; task 09 fib_recursive — expected output: 102334155
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 09_fib_recursive.ss
;; note: naive fib(40): about 331 million calls, so this measures the call path itself
;;       rather than any arithmetic. Each level is a real call; the two recursive calls are
;;       not in tail position, so nothing is turned into a loop.

(define (fib n)
  (if (fx< n 2)
      n
      (fx+ (fib (fx- n 1)) (fib (fx- n 2)))))

(display (fib 40))
(newline)
