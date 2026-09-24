# task 09 fib_recursive — expected output: 102334155
# build: none (interpreted)    run: nu 09_fib_recursive.nu
#
# Naive recursion, no memoization: fib(40) is about 331 million calls.

def fib [n: int] {
    if $n < 2 {
        $n
    } else {
        (fib ($n - 1)) + (fib ($n - 2))
    }
}

print (fib 40)
