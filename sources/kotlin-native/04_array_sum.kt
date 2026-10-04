// task 04 array_sum — expected output: 499999500000
// build: kotlinc 04_array_sum.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog 04_array_sum.kt    native run: ./prog]

import kotlin.time.TimeSource
import kotlinx.cinterop.ExperimentalForeignApi
import platform.posix.fputs
import platform.posix.stderr

@OptIn(ExperimentalForeignApi::class)
fun main() {
    val __t0 = TimeSource.Monotonic.markNow()
    val n = 1000000
    val array = IntArray(n)
    for (i in 0 until n) {
        array[i] = i
    }
    var total = 0L
    for (i in 0 until n) {
        total += array[i]
    }
    fputs("TIME_MS=" + __t0.elapsedNow().inWholeNanoseconds / 1000000.0 + "\n", stderr)
    println(total)
}
