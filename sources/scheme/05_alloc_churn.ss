;; task 05 alloc_churn — expected output: 1274991808
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 05_alloc_churn.ss
;; note: ten million 64-byte bytevectors, each stored into one of 256 slots so the buffer it
;;       replaces becomes garbage -- the same reachability line the C and Java rows draw, and
;;       the reason Chez's collector has something to do here. The total adds v, the value
;;       written, exactly as the Java row does.
;; note: bytevectors are the unboxed byte array (Chez's R6RS name for `bytes`), so each
;;       allocation is one 64-byte block plus a header, not 64 boxed objects.

(define slots (make-vector 256 #f))

(let loop ([i 0] [total 0])
  (if (fx= i 10000000)
      (begin (display total) (newline))
      (let ([v (fxmod i 256)])
        (let ([buf (make-bytevector 64 0)])
          (bytevector-u8-set! buf 0 v)
          (vector-set! slots v buf))
        (loop (fx+ i 1) (fx+ total v)))))
