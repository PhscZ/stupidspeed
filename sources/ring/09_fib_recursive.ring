# task 09 fib_recursive — expected output: 102334155
# build: none (interpreted)    run: ring 09_fib_recursive.ring
# note: naive recursion, no memoisation, exactly the C row's shape. Every one of the ~331
#       million calls is an interpreted call, which is why this is one of the slow cells.
# note: Ring numbers are doubles; fib(40) = 102334155 is exact.

? fib(40)

func fib n
    if n < 2
        return n
    ok
    return fib(n - 1) + fib(n - 2)
