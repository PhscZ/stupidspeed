// task 09 fib_recursive — expected output: 102334155
// build: scalac -release 17 -d out 09_fib_recursive.scala
// run: java -cp "out;<scala>/maven2/org/scala-lang/scala3-library_3/<v>/scala3-library_3-<v>.jar;<scala>/maven2/org/scala-lang/scala-library/<v>/scala-library-<v>.jar" Main
// note: <scala> is the Scala distribution and <v> its version, 3.9.0 for the one this row was
//       measured with. Scala CLI's `scala` is a subcommand runner, so `scala Main` is not a
//       command it accepts; running the compiled class directly with `java -cp` is the
//       equivalent, and it keeps the JVM's own start-up out of the compiler's way.

object Main {
  private def fib(n: Long): Long =
    if (n < 2L) n else fib(n - 1L) + fib(n - 2L)

  def main(args: Array[String]): Unit = {
    println(fib(40L))
  }
}
