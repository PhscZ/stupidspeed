// task 11 parallel_sum — expected output: 7500000075000000
// build: kotlinc main.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog main.kt    native run: ./prog]
// note: this is the jvm row, using four java.lang.Thread workers; the native row has no java.lang and would need platform.posix pthreads instead.

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
    val partials = LongArray(4)
    val workers = Array(4) { t ->
        Thread {
            partials[t] = work(t.toLong())
        }
    }
    for (w in workers) w.start()
    for (w in workers) w.join()
    var total = 0L
    for (p in partials) total += p
    println(total)
}
