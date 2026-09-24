// task 09 fib_recursive — expected output: 102334155
// build: kotlinc main.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog main.kt    native run: ./prog]

private fun fib(n: Long): Long {
    if (n < 2L) return n
    return fib(n - 1L) + fib(n - 2L)
}

fun main() {
    println(fib(40L))
}
