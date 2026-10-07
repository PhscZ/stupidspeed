# task 09 fib_recursive — expected output: 102334155
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 09_fib_recursive.janet
# note: the recursion is the plain double call the spec asks for; there is no
#       memoization and no accumulator.
# note: fib(40) is about 331 million calls. The result, 102334155, is below 2^53, so the
#       arithmetic is exact.

# timing: os/clock is Janet's monotonic clock, in seconds as a double; TIME_MS goes to
#         stderr with eprintf and stdout is unchanged.
(def ss-t0 (os/clock))
(defn ss-report [] (eprintf "TIME_MS=%.3f\n" (* 1000 (- (os/clock) ss-t0))))

(defn fib [n]
  (if (< n 2)
    n
    (+ (fib (- n 1)) (fib (- n 2)))))

# fib(40) is evaluated into a variable first: computing it inside the print
# argument list would place all 331 million calls after the timer stops.
(def ss-r (fib 40))
(ss-report)
(print ss-r)
