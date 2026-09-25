// task 11 parallel_sum — expected output: 7500000075000000
// build: kotlinc-native -opt -o prog 11_parallel_sum.kt    run: ./prog
// note: this is the kotlin/native row. Four real threads over the fixed quarters, the same
// shape as the jvm file (sources/kotlin/11_parallel_sum.kt), which uses java.lang.Thread. Native has no
// java.lang, so this uses the stdlib Worker, which is a real OS thread plus a work queue.
// ObsoleteWorkersApi is an opt-in warning ("will be replaced with threads eventually"),
// not an error, and Worker has existed since Kotlin 1.3.

import kotlin.native.concurrent.ObsoleteWorkersApi
import kotlin.native.concurrent.TransferMode
import kotlin.native.concurrent.Worker

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

@OptIn(ObsoleteWorkersApi::class)
fun main() {
    val workers = Array(4) { Worker.start() }

    // The producer runs on this thread and carries t across; the job captures nothing, as
    // Worker.execute requires, and only calls the top-level work().
    val futures = Array(4) { t -> workers[t].execute(TransferMode.SAFE, { t.toLong() }) { arg -> work(arg) } }

    var total = 0L
    for (f in futures) total += f.result
    for (w in workers) w.requestTermination().result

    println(total)
}
