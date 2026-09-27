// task 03 func_sum — expected output: 100000000
// build: scalac -release 17 -d out 03_func_sum.scala
// run: java -cp "out;<scala>/maven2/org/scala-lang/scala3-library_3/<v>/scala3-library_3-<v>.jar;<scala>/maven2/org/scala-lang/scala-library/<v>/scala-library-<v>.jar" Main
// note: <scala> is the Scala distribution and <v> its version, 3.9.0 for the one this row was
//       measured with. Scala CLI's `scala` is a subcommand runner, so `scala Main` is not a
//       command it accepts; running the compiled class directly with `java -cp` is the
//       equivalent, and it keeps the JVM's own start-up out of the compiler's way.
// @noinline is scala.noinline (auto-imported); it stops the Scala inliner. The JVM JIT may still inline the call at run time.

object Main {
  @noinline private def addOne(n: Long): Long = n + 1L

  def main(args: Array[String]): Unit = {
    var value = 0L
    var i = 0L
    while (i < 100000000L) {
      value = addOne(value)
      i += 1L
    }
    println(value)
  }
}
