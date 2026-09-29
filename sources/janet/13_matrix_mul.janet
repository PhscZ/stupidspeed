# task 13 matrix_mul — expected output: 599995000
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 13_matrix_mul.janet
# note: the matrices are flat 250000-element arrays indexed i * n + j, the same layout the C
#       row uses.
# note: the loop order is the plain i, j, k the spec asks for, so B is walked down a column
#       at a time. Reordering it would be faster and that is the point of the task, so it is
#       left alone.
# note: each element of C is a sum of 500 terms each at most 6 * 4 = 24, so it fits easily
#       in a double; the grand total, 599995000, is below 2^53 and exact.
(def n 500)
(def A (array/new-filled (* n n) 0))
(def B (array/new-filled (* n n) 0))
(def C (array/new-filled (* n n) 0))

(for i 0 n
  (for j 0 n
    (put A (+ (* i n) j) (% (+ i j) 7))
    (put B (+ (* i n) j) (% (* i j) 5))))

(for i 0 n
  (for j 0 n
    (var sum 0)
    (for k 0 n
      (+= sum (* (in A (+ (* i n) k)) (in B (+ (* k n) j)))))
    (put C (+ (* i n) j) sum)))

(var total 0)
(for k 0 (* n n)
  (+= total (in C k)))

(print total)
