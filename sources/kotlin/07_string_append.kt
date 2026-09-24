// task 07 string_append — expected output: 1000000
// build: kotlinc 07_string_append.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog 07_string_append.kt    native run: ./prog]

fun main() {
    var text = ""
    for (i in 0 until 1000000) {
        text += "x"
    }
    println(text.length)
}
