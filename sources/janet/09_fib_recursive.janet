# task 09 fib_recursive — expected output: 102334155
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 09_fib_recursive.janet
# note: the recursion is the plain double call the spec asks for; there is no
#       memoization and no accumulator.
# note: fib(40) is about 331 million calls. The result, 102334155, is below 2^53, so the
#       arithmetic is exact.
(defn fib [n]
  (if (< n 2)
    n
    (+ (fib (- n 1)) (fib (- n 2)))))

(print (fib 40))
