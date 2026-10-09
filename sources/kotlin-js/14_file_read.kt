// task 14 file_read — expected output: 2389704704
// build: tools/kotlin/kotlinc/bin/kotlinc-js.bat -libraries tools/kotlin/kotlinc/lib/kotlin-stdlib-js.klib \
//          -ir-output-dir klib-js -ir-output-name prog 14_file_read.kt
//        tools/kotlin/kotlinc/bin/kotlinc-js.bat -libraries tools/kotlin/kotlinc/lib/kotlin-stdlib-js.klib \
//          -Xir-produce-js -Xinclude=<taskdir>/klib-js/prog.klib -ir-output-dir <taskdir> -ir-output-name prog
// run: tools/nodejs/node.exe prog.js
// note: the Kotlin/JS row. Kotlin/JS has no file API of its own, so data.bin is reached through
//       node's fs module via js("require('fs')") -- the same route the Scala.js row takes
//       (sources/scala-js/14_file_read.scala) -- and read in 1 MiB chunks, the same 1 MiB the jvm
//       file uses.
// note: node has no text mode: readSync fills a Uint8Array (Kotlin/JS's ByteArray) with the raw
//       bytes, so the scan sees the same 0..255 values the jvm row masks out of its signed bytes,
//       and the running total is reduced mod 2^32 the same way.
// note: the body is the jvm file's (sources/kotlin/14_file_read.kt) with java.io.FileInputStream
//       replaced by node's fs and the clock lines in the JS form.

import kotlin.time.TimeSource

/** TIME_MS goes to fd 2 -- node's stderr -- as the contract requires. */
private fun writeErr(message: String) {
    js("process.stderr.write(message + '\\n')")
}

fun main() {
    val __t0 = TimeSource.Monotonic.markNow()
    val fs = js("require('fs')")
    val fd = fs.openSync("data.bin", "r") as Int
    val buf = ByteArray(1024 * 1024)
    var total = 0L
    while (true) {
        val got = fs.readSync(fd, buf, 0, buf.size, null) as Int
        if (got <= 0) break
        var i = 0
        while (i < got) {
            total += (buf[i].toInt() and 0xFF).toLong()
            i++
        }
    }
    fs.closeSync(fd)
    writeErr("TIME_MS=" + __t0.elapsedNow().inWholeNanoseconds / 1000000.0)
    println(total % 4294967296L)
}
