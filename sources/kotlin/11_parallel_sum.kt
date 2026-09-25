// task 11 parallel_sum — expected output: 7500000075000000
// build: kotlinc 11_parallel_sum.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native row: sources/kotlin-native/11_parallel_sum.kt]
// note: this is the jvm row, using four java.lang.Thread workers. The native row's file,
// sources/kotlin-native/11_parallel_sum.kt, uses the stdlib Worker because Native has no java.lang.

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
