// task 03 func_sum — expected output: 100000000
// build: none (interpreted)    run: groovy 03_func_sum.groovy
// Groovy dispatches method calls dynamically through the metaclass, so the hundred
// million calls are real calls and not inlined away, the same position Java and Scala
// are in. The method is `private static` so it is not a metaclass lookup.

private static long addOne(long n) {
    return n + 1L
}

long value = 0
for (long i = 0; i < 100000000L; i++) {
    value = addOne(value)
}

println value
