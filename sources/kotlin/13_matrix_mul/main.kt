// task 13 matrix_mul — expected output: 599995000
// build: kotlinc main.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog main.kt    native run: ./prog]

fun main() {
    val n = 500
    val a = LongArray(n * n)
    val b = LongArray(n * n)
    val c = LongArray(n * n)
    for (i in 0 until n) {
        for (j in 0 until n) {
            a[i * n + j] = ((i + j) % 7).toLong()
            b[i * n + j] = ((i * j) % 5).toLong()
        }
    }
    for (i in 0 until n) {
        for (j in 0 until n) {
            var sum = 0L
            for (k in 0 until n) {
                sum += a[i * n + k] * b[k * n + j]
            }
            c[i * n + j] = sum
        }
    }
    var total = 0L
    for (i in 0 until n * n) {
        total += c[i]
    }
    println(total)
}
