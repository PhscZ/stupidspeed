// task 15 file_write — expected output: 104857600
// build: kotlinc main.kt -include-runtime -d prog.jar    run: java -jar prog.jar    (jvm row only)
// note: java.io is not available on Kotlin/Native, so this file targets the jvm row; the native row would need platform.posix write(2). Writes out.bin in 1 MiB chunks.

import java.io.FileOutputStream

fun main() {
    val chunk = 1024 * 1024
    val buf = ByteArray(chunk)
    for (i in 0 until chunk) {
        buf[i] = (i % 256).toByte()
    }
    var written = 0L
    FileOutputStream("out.bin").use { out ->
        for (t in 0 until 100) {
            out.write(buf)
            written += chunk.toLong()
        }
        out.flush()
        out.getFD().sync()
    }
    println(written)
}
