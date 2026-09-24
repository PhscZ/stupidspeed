# task 09 fib_recursive — expected output: 102334155
# build: none (interpreted)    run: nu main.nu
#
# Naive recursion, no memoization: fib(40) is about 1.6 billion calls.

def fib [n: int] {
    if $n < 2 {
        $n
    } else {
        (fib ($n - 1)) + (fib ($n - 2))
    }
}

print (fib 40)
