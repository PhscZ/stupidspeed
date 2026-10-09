// task 11 parallel_sum — expected output: 7500000075000000
// build: tools/kotlin/kotlinc/bin/kotlinc-js.bat -libraries tools/kotlin/kotlinc/lib/kotlin-stdlib-js.klib \
//          -ir-output-dir klib-js -ir-output-name prog 11_parallel_sum.kt
//        tools/kotlin/kotlinc/bin/kotlinc-js.bat -libraries tools/kotlin/kotlinc/lib/kotlin-stdlib-js.klib \
//          -Xir-produce-js -Xinclude=<taskdir>/klib-js/prog.klib -ir-output-dir <taskdir> -ir-output-name prog
// run: tools/nodejs/node.exe prog.js
// note: the Kotlin/JS row. Kotlin/JS has no java.lang.Thread and no worker primitive, and node's
//       worker_threads are not reachable from a kotlinc-js CommonJS bundle without a hand-written
//       host, so the four quarters are computed serially in the caller -- the same disposition as
//       the Scala.js row (sources/scala-js/11_parallel_sum.scala) and the wasm rows whose runtime
//       has no threads.
// note: correct-answer-no-speedup. work(), the four fixed quarters and the summation are the jvm
//       file's, so the answer is the same 7500000075000000; only the overlap is missing.
// note: the body is the jvm file's (sources/kotlin/11_parallel_sum.kt) with the clock lines in the
//       JS form and the four java.lang.Thread workers replaced by a serial loop.

import kotlin.time.TimeSource

/** TIME_MS goes to fd 2 -- node's stderr -- as the contract requires. */
private fun writeErr(message: String) {
    js("process.stderr.write(message + '\\n')")
}

private fun work(t: Long): Long {
    var acc = 0L
    var i = t * 25000000L
    val end = (t + 1L) * 25000000L
    while (i < end) {
        when (i % 4L) {
            0L -> acc += 1L
            1L -> acc += i
            2L -> acc += 2L * i
            else -> acc += 3L * i
        }
        i++
    }
    return acc
}

fun main() {
    val __t0 = TimeSource.Monotonic.markNow()
    var total = 0L
    for (t in 0 until 4) total += work(t.toLong())
    writeErr("TIME_MS=" + __t0.elapsedNow().inWholeNanoseconds / 1000000.0)
    println(total)
}
