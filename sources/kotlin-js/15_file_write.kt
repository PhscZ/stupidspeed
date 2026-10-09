// task 15 file_write — expected output: 52428800
// build: tools/kotlin/kotlinc/bin/kotlinc-js.bat -libraries tools/kotlin/kotlinc/lib/kotlin-stdlib-js.klib \
//          -ir-output-dir klib-js -ir-output-name prog 15_file_write.kt
//        tools/kotlin/kotlinc/bin/kotlinc-js.bat -libraries tools/kotlin/kotlinc/lib/kotlin-stdlib-js.klib \
//          -Xir-produce-js -Xinclude=<taskdir>/klib-js/prog.klib -ir-output-dir <taskdir> -ir-output-name prog
// run: tools/nodejs/node.exe prog.js
// note: the Kotlin/JS row. Kotlin/JS has no file API of its own, so out.bin is written through
//       node's fs module via js("require('fs')") -- the same route the Scala.js row takes
//       (sources/scala-js/15_file_write.scala) -- as 50 chunks of the 1 MiB pattern, the same 1 MiB
//       the jvm file uses.
// note: openSync's "w" flag is binary in node -- there is no text mode, so no BOM and no newline
//       translation can be added to the bytes -- and fsyncSync is a real fsync on the same fd, the
//       same commit getFD().sync() gives the jvm row.
// note: the body is the jvm file's (sources/kotlin/15_file_write.kt) with java.io.FileOutputStream
//       replaced by node's fs and the clock lines in the JS form.

import kotlin.time.TimeSource

/** TIME_MS goes to fd 2 -- node's stderr -- as the contract requires. */
private fun writeErr(message: String) {
    js("process.stderr.write(message + '\\n')")
}

fun main() {
    val __t0 = TimeSource.Monotonic.markNow()
    val chunk = 1024 * 1024
    val buf = ByteArray(chunk)
    for (i in 0 until chunk) {
        buf[i] = (i % 256).toByte()
    }
    val fs = js("require('fs')")
    val fd = fs.openSync("out.bin", "w") as Int
    var written = 0L
    for (t in 0 until 50) {
        fs.writeSync(fd, buf, 0, buf.size)
        written += chunk.toLong()
    }
    fs.fsyncSync(fd)
    fs.closeSync(fd)
    writeErr("TIME_MS=" + __t0.elapsedNow().inWholeNanoseconds / 1000000.0)
    println(written)
}
