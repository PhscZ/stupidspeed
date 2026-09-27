// task 05 alloc_churn — expected output: 1274991808
// build: scalac -release 17 -d out 05_alloc_churn.scala
// run: java -cp "out;<scala>/maven2/org/scala-lang/scala3-library_3/<v>/scala3-library_3-<v>.jar;<scala>/maven2/org/scala-lang/scala-library/<v>/scala-library-<v>.jar" Main
// note: <scala> is the Scala distribution and <v> its version, 3.9.0 for the one this row was
//       measured with. Scala CLI's `scala` is a subcommand runner, so `scala Main` is not a
//       command it accepts; running the compiled class directly with `java -cp` is the
//       equivalent, and it keeps the JVM's own start-up out of the compiler's way.

object Main {
  def main(args: Array[String]): Unit = {
    var total = 0L
    val slots = new Array[Array[Byte]](256)
    var i = 0L
    while (i < 10000000L) {
      val buf = new Array[Byte](64)
      buf(0) = (i % 256L).toByte
      total += (buf(0) & 0xFF).toLong
      slots((i % 256L).toInt) = buf
      i += 1L
    }
    println(total)
  }
}
