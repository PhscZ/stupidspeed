// task 12 matrix_add — expected output: 999000000
// build: kotlinc 12_matrix_add.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog 12_matrix_add.kt    native run: ./prog]

fun main() {
    val n = 1000
    val a = LongArray(n * n)
    val b = LongArray(n * n)
    val c = LongArray(n * n)
    for (i in 0 until n) {
        for (j in 0 until n) {
            a[i * n + j] = (i + j).toLong()
            b[i * n + j] = (i - j).toLong()
        }
    }
    for (i in 0 until n) {
        for (j in 0 until n) {
            c[i * n + j] = a[i * n + j] + b[i * n + j]
        }
    }
    var total = 0L
    for (i in 0 until n * n) {
        total += c[i]
    }
    println(total)
}
