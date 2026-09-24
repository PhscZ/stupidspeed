// task 02 switch_case — expected output: 7500000075000000
// build: kotlinc main.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog main.kt    native run: ./prog]

fun main() {
    var acc = 0L
    for (i in 0L until 100000000L) {
        when (i % 4L) {
            0L -> acc += 1L
            1L -> acc += i
            2L -> acc += 2L * i
            else -> acc += 3L * i
        }
    }
    println(acc)
}
