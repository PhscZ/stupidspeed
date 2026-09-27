// task 04 array_sum — expected output: 499999500000
// build: scalac -release 17 -d out 04_array_sum.scala
// run: java -cp "out;<scala>/maven2/org/scala-lang/scala3-library_3/<v>/scala3-library_3-<v>.jar;<scala>/maven2/org/scala-lang/scala-library/<v>/scala-library-<v>.jar" Main
// note: <scala> is the Scala distribution and <v> its version, 3.9.0 for the one this row was
//       measured with. Scala CLI's `scala` is a subcommand runner, so `scala Main` is not a
//       command it accepts; running the compiled class directly with `java -cp` is the
//       equivalent, and it keeps the JVM's own start-up out of the compiler's way.

object Main {
  def main(args: Array[String]): Unit = {
    val array = new Array[Long](1000000)
    var i = 0
    while (i < 1000000) {
      array(i) = i.toLong
      i += 1
    }
    var total = 0L
    i = 0
    while (i < 1000000) {
      total += array(i)
      i += 1
    }
    println(total)
  }
}
