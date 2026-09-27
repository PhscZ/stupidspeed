// task 07 string_append — expected output: 1000000
// build: scalac -release 17 -d out 07_string_append.scala
// run: java -cp "out;<scala>/maven2/org/scala-lang/scala3-library_3/<v>/scala3-library_3-<v>.jar;<scala>/maven2/org/scala-lang/scala-library/<v>/scala-library-<v>.jar" Main
// note: <scala> is the Scala distribution and <v> its version, 3.9.0 for the one this row was
//       measured with. Scala CLI's `scala` is a subcommand runner, so `scala Main` is not a
//       command it accepts; running the compiled class directly with `java -cp` is the
//       equivalent, and it keeps the JVM's own start-up out of the compiler's way.

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
