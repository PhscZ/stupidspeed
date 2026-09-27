// task 12 matrix_add — expected output: 999000000
// build: scalac -release 17 -d out 12_matrix_add.scala
// run: java -cp "out;<scala>/maven2/org/scala-lang/scala3-library_3/<v>/scala3-library_3-<v>.jar;<scala>/maven2/org/scala-lang/scala-library/<v>/scala-library-<v>.jar" Main
// note: <scala> is the Scala distribution and <v> its version, 3.9.0 for the one this row was
//       measured with. Scala CLI's `scala` is a subcommand runner, so `scala Main` is not a
//       command it accepts; running the compiled class directly with `java -cp` is the
//       equivalent, and it keeps the JVM's own start-up out of the compiler's way.

object Main {
  def main(args: Array[String]): Unit = {
    val n = 1000
    val size = n * n
    val a = new Array[Long](size)
    val b = new Array[Long](size)
    val c = new Array[Long](size)

    var i = 0
    while (i < n) {
      var j = 0
      while (j < n) {
        a(i * n + j) = (i + j).toLong
        j += 1
      }
      i += 1
    }

    i = 0
    while (i < n) {
      var j = 0
      while (j < n) {
        b(i * n + j) = (i - j).toLong
        j += 1
      }
      i += 1
    }

    i = 0
    while (i < n) {
      var j = 0
      while (j < n) {
        c(i * n + j) = a(i * n + j) + b(i * n + j)
        j += 1
      }
      i += 1
    }

    var total = 0L
    i = 0
    while (i < size) {
      total += c(i)
      i += 1
    }
    println(total)
  }
}
