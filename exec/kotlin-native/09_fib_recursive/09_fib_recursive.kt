// task 09 fib_recursive — expected output: 102334155
// build: kotlinc 09_fib_recursive.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog 09_fib_recursive.kt    native run: ./prog]

import kotlin.time.TimeSource
import kotlinx.cinterop.ExperimentalForeignApi
import platform.posix.fputs
import platform.posix.stderr

private fun fib(n: Long): Long {
    if (n < 2L) return n
    return fib(n - 1L) + fib(n - 2L)
}

@OptIn(ExperimentalForeignApi::class)
fun main() {
    val __t0 = TimeSource.Monotonic.markNow()
    val result = fib(40L)
    fputs("TIME_MS=" + __t0.elapsedNow().inWholeNanoseconds / 1000000.0 + "\n", stderr)
    println(result)
}
