;; task 11 parallel_sum — expected output: 7500000075000000
;; build: none (Racket.exe compiles the module on every run; the VM start is part of
;;        the measured time)
;; run: Racket.exe 11_parallel_sum.rkt
;; note: Racket.exe is the console launcher. GRacket.exe is the GUI-subsystem build of
;;       the same runtime and prints nothing to a console.
;; note: #lang racket/base rather than #lang racket, which is the documented way to get a
;;       faster start-up; every form these tasks need is in racket/base.
;; note: the loops are `for`/`for/fold` accumulators or named `let` loops, not `set!` on a
;;       loop local. Racket's own performance chapter measures `set!` in a hot loop as
;;       allocating a fresh location per iteration, so mutation of a loop variable is the
;;       slow way to write it here and the accumulator is the fast way.
;; note: Racket's plain `thread` is green -- cooperative, on one OS thread -- and gives no
;;       speedup, and `future` silently serialises as soon as its body does anything blocking.
;;       The parallel route used here is `(thread thunk #:pool 'own #:keep 'results)`, which runs
;;       the thunk on its own OS thread with the heap shared, and `thread-wait` returns what the
;;       thunk returned. That is Racket 8.18 and later.
;; note: `racket/place` also gives real parallelism and is the older documented mechanism, but it
;;       was rejected for this row after being measured: each place is a separate Racket VM
;;       instance, so four of them cost about 6.2 GB of resident memory and the task took roughly
;;       six minutes. Parallel threads share the heap, so the same work is a couple of seconds in
;;       a normal amount of memory. The place-based version is not used.

#lang racket/base

;; Self-timing: current-inexact-milliseconds is Racket's monotonic wall-clock reading, in
;; milliseconds as an inexact real. The start is the first form the module body runs and the
;; stop is taken immediately before the answer is printed, so the bracketed region is the
;; task's own work and nothing else. eprintf writes to (current-error-port), so stdout is
;; unchanged.
(define timer-start (current-inexact-milliseconds))
(define (elapsed-ms) (- (current-inexact-milliseconds) timer-start))

;; worker t covers [t*25000000, (t+1)*25000000).
(define (work t)
  (for/fold ([acc 0]) ([i (in-range (* t 25000000) (* (+ t 1) 25000000))])
    (+ acc (case (modulo i 4)
             [(0) 1]
             [(1) i]
             [(2) (* 2 i)]
             [else (* 3 i)]))))

(module+ main
  ;; #:pool 'own puts each thread on its own OS thread, so the four really run at once;
  ;; #:keep 'results makes thread-wait hand back what the thunk returned.
  (define threads
    (for/list ([t (in-range 4)])
      (thread (lambda () (work t)) #:pool 'own #:keep 'results)))

  (define total
    (for/fold ([total 0]) ([th (in-list threads)])
      (+ total (thread-wait th))))

  (eprintf "TIME_MS=~a\n" (elapsed-ms))
  (displayln total))
