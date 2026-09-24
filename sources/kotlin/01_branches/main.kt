// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: kotlinc main.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog main.kt    native run: ./prog]

fun main() {
    var a = 0L
    var b = 0L
    var c = 0L
    var d = 0L
    for (i in 0L until 100000000L) {
        if (i % 3L == 0L) {
            a++
        } else if (i % 5L == 0L) {
            b++
        } else if (i % 7L == 0L) {
            c++
        } else {
            d++
        }
    }
    println("$a $b $c $d")
}
