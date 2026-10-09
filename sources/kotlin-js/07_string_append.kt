// task 07 string_append — expected output: 250000
// build: tools/kotlin/kotlinc/bin/kotlinc-js.bat -libraries tools/kotlin/kotlinc/lib/kotlin-stdlib-js.klib \
//          -ir-output-dir klib-js -ir-output-name prog 07_string_append.kt
//        tools/kotlin/kotlinc/bin/kotlinc-js.bat -libraries tools/kotlin/kotlinc/lib/kotlin-stdlib-js.klib \
//          -Xir-produce-js -Xinclude=<taskdir>/klib-js/prog.klib -ir-output-dir <taskdir> -ir-output-name prog
// run: tools/nodejs/node.exe prog.js
// note: the Kotlin/JS row, built by Kotlin 2.4.20's IR JS backend (kotlinc-js) and run under
//       tools/nodejs/node.exe (node 22.20.0). Kotlin 2.4.20 needs two compiler invocations: a klib
//       cannot be produced and linked to JS in the same K2 invocation, so the klib is linked by
//       -Xir-produce-js -Xinclude=<klib>.
// note: the body is the jvm file's (sources/kotlin/07_string_append.kt) with the two clock lines in the JS
//       form -- kotlin.time.TimeSource.Monotonic instead of System.nanoTime(), and stderr through
//       node's process.stderr instead of System.err -- so the measured work is the same work.
import kotlin.time.TimeSource

/** TIME_MS goes to fd 2 -- node's stderr -- as the contract requires. */
private fun writeErr(message: String) {
    js("process.stderr.write(message + '\\n')")
}

fun main() {
    val __t0 = TimeSource.Monotonic.markNow()
    var text = ""
    for (i in 0 until 250000) {
        text += "x"
    }
    writeErr("TIME_MS=" + __t0.elapsedNow().inWholeNanoseconds / 1000000.0)
    println(text.length)
}
