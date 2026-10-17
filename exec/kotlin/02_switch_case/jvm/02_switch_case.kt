// task 02 switch_case — expected output: 8748000081000000
// build: kotlinc 02_switch_case.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog 02_switch_case.kt    native run: ./prog]

fun main() {
    val __t0 = System.nanoTime()
    var acc = 0L
    for (i in 0L until 108000000L) {
        when (i % 4L) {
            0L -> acc += 1L
            1L -> acc += i
            2L -> acc += 2L * i
            else -> acc += 3L * i
        }
    }
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(acc)
}
