// task 07 string_append — expected output: 250000
// build: kotlinc 07_string_append.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog 07_string_append.kt    native run: ./prog]

fun main() {
    var text = ""
    for (i in 0 until 250000) {
        text += "x"
    }
    println(text.length)
}
