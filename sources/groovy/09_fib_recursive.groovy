// task 09 fib_recursive — expected output: 102334155
// build: none (interpreted)    run: groovy 09_fib_recursive.groovy
// The recursive method is typed `long`, so the 331 million calls go through a real
// method invocation rather than Groovy's dynamic dispatch machinery.

static long fib(long n) {
    if (n < 2L) {
        return n
    }
    return fib(n - 1L) + fib(n - 2L)
}

println fib(40L)
