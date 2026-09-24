// task 15 file_write — expected output: 104857600
// build: kotlinc 15_file_write.kt -include-runtime -d prog.jar    run: java -jar prog.jar    (jvm row; the native row builds 15_file_write_native.kt)
// note: java.io is not available on Kotlin/Native, so the native row has its own file, which
// writes out.bin with platform.posix instead. This one writes it in 1 MiB chunks.

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
