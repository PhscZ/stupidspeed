// task 06 char_count — expected output: 10000000
// build: scalac -release 17 -d out 06_char_count.scala
// run: java -cp "out;<scala>/maven2/org/scala-lang/scala3-library_3/<v>/scala3-library_3-<v>.jar;<scala>/maven2/org/scala-lang/scala-library/<v>/scala-library-<v>.jar" Main
// note: <scala> is the Scala distribution and <v> its version, 3.9.0 for the one this row was
//       measured with. Scala CLI's `scala` is a subcommand runner, so `scala Main` is not a
//       command it accepts; running the compiled class directly with `java -cp` is the
//       equivalent, and it keeps the JVM's own start-up out of the compiler's way.

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
