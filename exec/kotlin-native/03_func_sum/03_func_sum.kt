// task 03 func_sum — expected output: 100000000
// build: kotlinc 03_func_sum.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog 03_func_sum.kt    native run: ./prog]
// note: Kotlin has no no-inline marker in the common stdlib; a plain top-level function is the idiomatic form, and Kotlin/JVM may still inline addOne at run time.

import kotlin.time.TimeSource
import kotlinx.cinterop.ExperimentalForeignApi
import platform.posix.fputs
import platform.posix.stderr

private fun addOne(n: Long): Long = n + 1L

@OptIn(ExperimentalForeignApi::class)
fun main() {
    val __t0 = TimeSource.Monotonic.markNow()
    var value = 0L
    for (i in 0 until 100000000) {
        value = addOne(value)
    }
    fputs("TIME_MS=" + __t0.elapsedNow().inWholeNanoseconds / 1000000.0 + "\n", stderr)
    println(value)
}
