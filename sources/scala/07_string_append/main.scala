// task 07 string_append — expected output: 1000000
// build: scalac -release 17 main.scala    run: scala Main

object Main {
  def main(args: Array[String]): Unit = {
    var text = ""
    var i = 0L
    while (i < 1000000L) {
      text = text + "x"
      i += 1L
    }
    println(text.length)
  }
}
