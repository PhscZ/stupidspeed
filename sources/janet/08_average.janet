# task 08 average — expected output: 0.498046875
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 08_average.janet
# note: `(i % 256) / 256.0` is the same expression the C row evaluates, and it is the only
#       numeric type Janet has. Every reading is a multiple of 1/256 and the running total
#       never passes 5e7, so every partial sum is exact in binary and the answer does not
#       depend on the order of the additions.
# note: `print` formats a non-integral double with "%.15g", which emits 0.498046875 exactly
#       with a period for the decimal point, so no hand-rolled formatter is needed.
(var total 0.0)

(for i 0 100000000
  (def reading (/ (% i 256) 256.0))
  (+= total reading))

(print (/ total 100000000.0))
