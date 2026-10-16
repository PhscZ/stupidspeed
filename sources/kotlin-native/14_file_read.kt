// task 14 file_read — expected output: 1937768448
// build: kotlinc-native -opt -o prog 14_file_read.kt    run: ./prog
// note: this is the kotlin/native row. Native has no stdlib file I/O and no java.io, so
// data.bin is read with the platform C library (fopen/fread/fclose) from the working
// directory in 1 MiB chunks, the same 1 MiB the jvm file (sources/kotlin/14_file_read.kt) uses;
// the file is opened and read eight times over, accumulating into one running total.
// kotlinx.cinterop and platform.posix ship with the Kotlin/Native compiler and stdio.h is
// in the POSIX platform library for Linux, macOS and Windows alike, so this is still the
// standard distribution and not a third-party dependency.

import kotlinx.cinterop.ExperimentalForeignApi
import kotlinx.cinterop.addressOf
import kotlinx.cinterop.convert
import kotlinx.cinterop.usePinned
import platform.posix.fclose
import platform.posix.fopen
import platform.posix.fread
import kotlin.time.TimeSource
import platform.posix.fputs
import platform.posix.stderr

@OptIn(ExperimentalForeignApi::class)
fun main() {
    val __t0 = TimeSource.Monotonic.markNow()
    val buf = ByteArray(1024 * 1024)
    var total = 0L
    var pass = 0
    while (pass < 8) {
        val file = fopen("data.bin", "rb")
        if (file == null) return
        while (true) {
            val got = buf.usePinned { p -> fread(p.addressOf(0), 1.convert(), buf.size.convert(), file) }
            if (got.toLong() == 0L) break
            var i = 0
            while (i < got.toInt()) {
                total += (buf[i].toInt() and 0xFF).toLong()
                i++
            }
        }
        fclose(file)
        pass++
    }
    fputs("TIME_MS=" + __t0.elapsedNow().inWholeNanoseconds / 1000000.0 + "\n", stderr)
    println(total % 4294967296L)
}
