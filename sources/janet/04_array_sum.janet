# task 04 array_sum — expected output: 599999940000000
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 04_array_sum.janet
# note: `(array/new-filled 10000000 0)` is a contiguous array of ten million doubles, 80 MB,
#       the same width the C row's int64 array has. `put` and `in` compile to the JOP_PUT
#       and JOP_IN opcodes.
# note: the running total passes 2^31, but it is a double from the start and 599999940000000
#       is below 2^53, so the sum is exact and `print` emits it as plain digits.

# timing: os/clock is Janet's monotonic clock, in seconds as a double; TIME_MS goes to
#         stderr with eprintf and stdout is unchanged.
(def ss-t0 (os/clock))
(defn ss-report [] (eprintf "TIME_MS=%.3f\n" (* 1000 (- (os/clock) ss-t0))))

(def arr (array/new-filled 10000000 0))

(for i 0 10000000
  (put arr i i))

(var total 0)
(for _pass 0 12
  (for i 0 10000000
    (+= total (in arr i))))

(ss-report)
(print total)
