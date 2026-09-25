// task 15 file_write — expected output: 104857600
// build: kotlinc-native -opt -o prog 15_file_write.kt    run: ./prog
// note: this is the kotlin/native row. Native has no stdlib file I/O and no java.io, so
// out.bin is written with the platform C library (fopen/fwrite/fflush/fclose) in 1 MiB
// chunks, the same 1 MiB the jvm file (sources/kotlin/15_file_write.kt) uses. The jvm file also calls
// getFD().sync(); platform.posix has no fsync on every target (MinGW has none), so the
// deviation is flush + close, the same one the D, Julia, Nim, Dart and Pascal rows note.

import kotlinx.cinterop.ExperimentalForeignApi
import kotlinx.cinterop.addressOf
import kotlinx.cinterop.convert
import kotlinx.cinterop.usePinned
import platform.posix.fclose
import platform.posix.fflush
import platform.posix.fopen
import platform.posix.fwrite

@OptIn(ExperimentalForeignApi::class)
fun main() {
    val chunk = 1024 * 1024
    val buf = ByteArray(chunk)
    for (i in 0 until chunk) {
        buf[i] = (i % 256).toByte()
    }
    val file = fopen("out.bin", "wb")
    if (file == null) return
    var written = 0L
    for (t in 0 until 100) {
        written += buf.usePinned { p -> fwrite(p.addressOf(0), 1.convert(), buf.size.convert(), file) }.toLong()
    }
    fflush(file)
    fclose(file)
    println(written)
}
