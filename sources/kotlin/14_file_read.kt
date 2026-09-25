// task 14 file_read — expected output: 484442112
// build: kotlinc 14_file_read.kt -include-runtime -d prog.jar    run: java -jar prog.jar    (jvm row; the native row's file is sources/kotlin-native/14_file_read.kt)
// note: java.io is not available on Kotlin/Native, so the native row has its own file there, which
// reads data.bin with platform.posix instead. This one reads it in 1 MiB chunks.

import java.io.FileInputStream

fun main() {
    val buf = ByteArray(1024 * 1024)
    var total = 0L
    FileInputStream("data.bin").use { input ->
        while (true) {
            val got = input.read(buf)
            if (got <= 0) break
            var i = 0
            while (i < got) {
                total += (buf[i].toInt() and 0xFF).toLong()
                i++
            }
        }
    }
    println(total % 4294967296L)
}
