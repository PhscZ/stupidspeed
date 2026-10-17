// task 15 file_write — expected output: 419430400
// build: kotlinc 15_file_write.kt -include-runtime -d prog.jar    run: java -jar prog.jar    (jvm row; the native row's file is sources/kotlin-native/15_file_write.kt)
// note: java.io is not available on Kotlin/Native, so the native row has its own file there, which
// writes out.bin with platform.posix instead. This one writes it in 1 MiB chunks: 50 per pass
// over 8 passes, each pass reopening out.bin (FileOutputStream truncates) at offset 0.

import java.io.FileOutputStream

fun main() {
    val __t0 = System.nanoTime()
    val chunk = 1024 * 1024
    val buf = ByteArray(chunk)
    for (i in 0 until chunk) {
        buf[i] = (i % 256).toByte()
    }
    var written = 0L
    for (pass in 0 until 8) {
        FileOutputStream("out.bin").use { out ->
            for (t in 0 until 50) {
                out.write(buf)
                written += chunk.toLong()
            }
            out.flush()
            out.getFD().sync()
        }
    }
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(written)
}
