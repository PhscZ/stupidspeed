# task 02 switch_case — expected output: 7500000075000000
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 02_switch_case.janet
# note: `case` is Janet's switch. It is a macro that expands to a chain of equality tests
#       against the dispatch value, not a jump table, which is the same shape the C row's
#       switch compiles to here.
# note: acc passes 2^31 in the first few iterations, but Janet has no 32-bit integer to
#       overflow: it is a double the whole way, and 7500000075000000 is below 2^53, so
#       every partial sum is exact and the printed value is exact.
# note: `print` formats an integral double below 2^53 with "%.0f", so the answer comes out
#       as plain digits, with no scientific notation and no decimal point.

# timing: os/clock is Janet's monotonic clock, in seconds as a double; TIME_MS goes to
#         stderr with eprintf and stdout is unchanged.
(def ss-t0 (os/clock))
(defn ss-report [] (eprintf "TIME_MS=%.3f\n" (* 1000 (- (os/clock) ss-t0))))

(var acc 0)

(for i 0 100000000
  (case (% i 4)
    0 (+= acc 1)
    1 (+= acc i)
    2 (+= acc (* 2 i))
    3 (+= acc (* 3 i))))

(ss-report)
(print acc)
