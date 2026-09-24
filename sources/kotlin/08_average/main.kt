// task 08 average — expected output: 0.498046875
// build: kotlinc main.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog main.kt    native run: ./prog]

fun main() {
    var total = 0.0
    for (i in 0 until 100000000) {
        val reading = (i % 256).toDouble() / 256.0
        total += reading
    }
    println(total / 100000000.0)
}
