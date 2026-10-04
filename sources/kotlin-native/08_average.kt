// task 08 average — expected output: 0.498046875
// build: kotlinc 08_average.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog 08_average.kt    native run: ./prog]

import kotlin.time.TimeSource
import kotlinx.cinterop.ExperimentalForeignApi
import platform.posix.fputs
import platform.posix.stderr

@OptIn(ExperimentalForeignApi::class)
fun main() {
    val __t0 = TimeSource.Monotonic.markNow()
    var total = 0.0
    for (i in 0 until 100000000) {
        val reading = (i % 256).toDouble() / 256.0
        total += reading
    }
    fputs("TIME_MS=" + __t0.elapsedNow().inWholeNanoseconds / 1000000.0 + "\n", stderr)
    println(total / 100000000.0)
}
