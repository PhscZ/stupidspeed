// task 08 average — expected output: 0.498046875
// build: kotlinc 08_average.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog 08_average.kt    native run: ./prog]

fun main() {
    val __t0 = System.nanoTime()
    var total = 0.0
    for (i in 0 until 100000000) {
        val reading = (i % 256).toDouble() / 256.0
        total += reading
    }
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(total / 100000000.0)
}
