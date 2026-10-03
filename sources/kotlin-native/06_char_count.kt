// task 06 char_count — expected output: 10000000
// build: kotlinc 06_char_count.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog 06_char_count.kt    native run: ./prog]

fun main() {
    val text = "abcdefghij".repeat(10000000)
    var count = 0L
    for (ch in text) {
        if (ch == 'h') {
            count++
        }
    }
    println(count)
}
