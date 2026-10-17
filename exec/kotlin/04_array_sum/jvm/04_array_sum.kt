// task 04 array_sum — expected output: 599999940000000
// build: kotlinc 04_array_sum.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog 04_array_sum.kt    native run: ./prog]

fun main() {
    val __t0 = System.nanoTime()
    val n = 10000000
    val array = IntArray(n)
    for (i in 0 until n) {
        array[i] = i
    }
    var total = 0L
    for (pass in 0 until 12) {
        for (i in 0 until n) {
            total += array[i]
        }
    }
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(total)
}
