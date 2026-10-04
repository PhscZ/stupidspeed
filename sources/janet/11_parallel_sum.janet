# task 11 parallel_sum — expected output: 7500000075000000
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 11_parallel_sum.janet
# note: the mechanism is Janet's own core `ev/` threads: `(ev/thread worker [t chan] :n)`
#       starts one real OS thread per worker and returns at once, and `(ev/thread-chan 4)`
#       is a channel that can be shared across threads. Each thread has its own Janet heap,
#       so the only way back is a message; each worker sends its partial with `(ev/give
#       chan acc)` and the parent collects the four with `(ev/take chan)`. This is the
#       isolates shape Dart and JavaScript use — real threads, no shared mutable state —
#       rather than a shared-heap thread like Racket's.
# note: `ev/thread` and threaded channels are core, not an extension, so nothing extra is
#       installed and no flag is needed. They landed in Janet 1.14.2 / 1.17.0, so the
#       toolchain floor for this task is 1.17.1.
# note: the worker function is self-contained — it closes over nothing but the core `case`
#       and `+=` — so marshalling it to the new heap is trivial; the worker index and the
#       channel are passed explicitly as the value argument.
# note: each worker owns a fixed quarter, so which one finishes first cannot change the
#       answer. The parent's total is a double and 7500000075000000 is below 2^53, so it is
#       exact and printed as plain digits.

# timing: os/clock is Janet's monotonic clock, in seconds as a double; TIME_MS goes to
#         stderr with eprintf and stdout is unchanged.
(def ss-t0 (os/clock))
(defn ss-report [] (eprintf "TIME_MS=%.3f\n" (* 1000 (- (os/clock) ss-t0))))

(defn worker [arg]
  (def [t chan] arg)
  (var acc 0)
  (def lo (* t 25000000))
  (def hi (+ lo 25000000))
  (for i lo hi
    (case (% i 4)
      0 (+= acc 1)
      1 (+= acc i)
      2 (+= acc (* 2 i))
      3 (+= acc (* 3 i))))
  (ev/give chan acc))

(def chan (ev/thread-chan 4))

(for t 0 4
  (ev/thread worker [t chan] :n))

(var total 0)
(for i 0 4
  (+= total (ev/take chan)))

(ss-report)
(print total)
