;; task 11 parallel_sum — expected output: 7500000075000000
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 11_parallel_sum.ss
;; note: Chez's threads are real OS threads. The User's Guide's threads chapter says the
;;       thread system is built on pthreads on Unix-like systems and directly on the Windows
;;       API on Windows, so four fork-thread workers really do run at once on four cores.
;;       The machine type must be a threaded one (ta6nt here); a --nothreads build has no
;;       fork-thread at all.
;; note: thread-join returns unspecified, so the four partial sums go into a shared fxvector
;;       that each worker writes its own slot of. No lock is needed: the slots are disjoint
;;       and the joins happen before the slots are read.
;; note: each worker owns a fixed quarter of the range, so which worker finishes first does
;;       not change the answer.
;; note: measured, not assumed. The same 100000000 iterations take 0.071-0.080 s of real time
;;       when they run on one fork-thread and 0.024-0.028 s when they are split over four --
;;       about 3.0x, on four cores. The four workers also report four distinct
;;       get-thread-id values, so they are four OS threads and not one thread time-sliced.

;; worker t covers [t*25000000, (t+1)*25000000).
;; timing: (real-time) is Chez's monotonic clock in milliseconds since system start-up;
;;         TIME_MS is written to time.txt, the contract's fallback, because Chez's
;;         console-error-port is the console and this host sends the console to stdout
;;         when it is redirected; stdout is unchanged.
(define ss-t0 (real-time))
(define (ss-report)
  (let ([p (open-file-output-port "time.txt" (file-options no-fail)
                                  (buffer-mode block))])
    (put-bytevector p (string->utf8
                       (string-append "TIME_MS="
                                      (number->string (- (real-time) ss-t0))
                                      "\n")))
    (close-port p)))
(define (work t)
  (let loop ([i (fx* t 25000000)] [acc 0])
    (if (fx= i (fx* (fx+ t 1) 25000000))
        acc
        (loop (fx+ i 1)
              (fx+ acc (case (fxmod i 4)
                         [(0) 1]
                         [(1) i]
                         [(2) (fx* 2 i)]
                         [else (fx* 3 i)]))))))

(define threads (make-vector 4))
(define partials (make-fxvector 4 0))

(let spawn ([t 0])
  (when (fx< t 4)
    (let ([id t])
      (vector-set! threads id
                   (fork-thread (lambda () (fxvector-set! partials id (work id))))))
    (spawn (fx+ t 1))))

(let loop ([t 0] [total 0])
  (if (fx= t 4)
      (begin (ss-report) (display total) (newline))
      (begin
        (thread-join (vector-ref threads t))
        (loop (fx+ t 1) (fx+ total (fxvector-ref partials t))))))
