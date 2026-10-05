// task 05 alloc_churn — expected output: 1274991808
// build: kotlinc 05_alloc_churn.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog 05_alloc_churn.kt    native run: ./prog]

import kotlin.time.TimeSource
import kotlinx.cinterop.ExperimentalForeignApi
import platform.posix.fputs
import platform.posix.stderr

@OptIn(ExperimentalForeignApi::class)
fun main() {
    val __t0 = TimeSource.Monotonic.markNow()
    var total = 0L
    val slots = arrayOfNulls<ByteArray>(256)
    for (i in 0 until 10000000) {
        val buf = ByteArray(64)
        buf[0] = (i % 256).toByte()
        total += (buf[0].toInt() and 0xFF).toLong()
        slots[i % 256] = buf
    }
    fputs("TIME_MS=" + __t0.elapsedNow().inWholeNanoseconds / 1000000.0 + "\n", stderr)
    println(total)
}
