# task 12 matrix_add — expected output: 999000000
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 12_matrix_add.janet
# note: the three matrices are three flat million-element arrays indexed i * n + j, which is
#       the same layout the C row uses; `put` and `in` are the JOP_PUT and JOP_IN opcodes.
# note: A holds i + j and B holds i - j, both small signed values; C holds their sum. The
#       grand total, 999000000, is below 2^53, so it is exact.

# timing: os/clock is Janet's monotonic clock, in seconds as a double; TIME_MS goes to
#         stderr with eprintf and stdout is unchanged.
(def ss-t0 (os/clock))
(defn ss-report [] (eprintf "TIME_MS=%.3f\n" (* 1000 (- (os/clock) ss-t0))))

(def n 1000)
(def A (array/new-filled (* n n) 0))
(def B (array/new-filled (* n n) 0))
(def C (array/new-filled (* n n) 0))

(for i 0 n
  (for j 0 n
    (put A (+ (* i n) j) (+ i j))
    (put B (+ (* i n) j) (- i j))))

(for i 0 n
  (for j 0 n
    (put C (+ (* i n) j) (+ (in A (+ (* i n) j)) (in B (+ (* i n) j))))))

(var total 0)
(for k 0 (* n n)
  (+= total (in C k)))

(ss-report)
(print total)
