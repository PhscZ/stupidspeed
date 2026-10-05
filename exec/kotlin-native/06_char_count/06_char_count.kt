// task 06 char_count — expected output: 10000000
// build: kotlinc 06_char_count.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog 06_char_count.kt    native run: ./prog]

import kotlin.time.TimeSource
import kotlinx.cinterop.ExperimentalForeignApi
import platform.posix.fputs
import platform.posix.stderr

@OptIn(ExperimentalForeignApi::class)
fun main() {
    val __t0 = TimeSource.Monotonic.markNow()
    val text = "abcdefghij".repeat(10000000)
    var count = 0L
    for (ch in text) {
        if (ch == 'h') {
            count++
        }
    }
    fputs("TIME_MS=" + __t0.elapsedNow().inWholeNanoseconds / 1000000.0 + "\n", stderr)
    println(count)
}
