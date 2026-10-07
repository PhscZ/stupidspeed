// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: kotlinc 01_branches.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog 01_branches.kt    native run: ./prog]

import kotlin.time.TimeSource
import kotlinx.cinterop.ExperimentalForeignApi
import platform.posix.fputs
import platform.posix.stderr

@OptIn(ExperimentalForeignApi::class)
fun main() {
    val __t0 = TimeSource.Monotonic.markNow()
    var a = 0L
    var b = 0L
    var c = 0L
    var d = 0L
    for (i in 0L until 100000000L) {
        if (i % 3L == 0L) {
            a++
        } else if (i % 5L == 0L) {
            b++
        } else if (i % 7L == 0L) {
            c++
        } else {
            d++
        }
    }
    fputs("TIME_MS=" + __t0.elapsedNow().inWholeNanoseconds / 1000000.0 + "\n", stderr)
    println("$a $b $c $d")
}
