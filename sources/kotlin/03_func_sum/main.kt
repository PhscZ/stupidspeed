// task 03 func_sum — expected output: 100000000
// build: kotlinc main.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog main.kt    native run: ./prog]
// note: Kotlin has no no-inline marker in the common stdlib; a plain top-level function is the idiomatic form, and Kotlin/JVM may still inline addOne at run time.

private fun addOne(n: Long): Long = n + 1L

fun main() {
    var value = 0L
    for (i in 0 until 100000000) {
        value = addOne(value)
    }
    println(value)
}
