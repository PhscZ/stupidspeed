# task 04 array_sum — expected output: 499999500000
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 04_array_sum.janet
# note: `(array/new-filled 1000000 0)` is a contiguous array of a million doubles, 8 MB,
#       the same width the C row's int64 array has. `put` and `in` compile to the JOP_PUT
#       and JOP_IN opcodes.
# note: the running total passes 2^31, but it is a double from the start and 499999500000 is
#       below 2^53, so the sum is exact and `print` emits it as plain digits.
(def arr (array/new-filled 1000000 0))

(for i 0 1000000
  (put arr i i))

(var total 0)
(for i 0 1000000
  (+= total (in arr i)))

(print total)
