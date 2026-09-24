// task 06 char_count — expected output: 10000000
// build: scalac -release 17 06_char_count.scala    run: scala Main

object Main {
  def main(args: Array[String]): Unit = {
    val text = "abcdefghij" * 10000000
    var count = 0L
    var i = 0
    val len = text.length
    while (i < len) {
      val ch = text.charAt(i)
      if (ch == 'a') ()
      else if (ch == 'e') ()
      else if (ch == 'h') count += 1L
      else ()
      i += 1
    }
    println(count)
  }
}
