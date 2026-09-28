// task 14 file_read — expected output: 2389704704
// build: scalac -release 17 -d out 14_file_read.scala
// run: java -cp "out;<scala>/maven2/org/scala-lang/scala3-library_3/<v>/scala3-library_3-<v>.jar;<scala>/maven2/org/scala-lang/scala-library/<v>/scala-library-<v>.jar" Main
// note: <scala> is the Scala distribution and <v> its version, 3.9.0 for the one this row was
//       measured with. Scala CLI's `scala` is a subcommand runner, so `scala Main` is not a
//       command it accepts; running the compiled class directly with `java -cp` is the
//       equivalent, and it keeps the JVM's own start-up out of the compiler's way.
// Reads data.bin (52428800 bytes) from the working directory in 1 MiB chunks.

import java.io.FileInputStream

object Main {
  def main(args: Array[String]): Unit = {
    val in = new FileInputStream("data.bin")
    try {
      val buf = new Array[Byte](1024 * 1024)
      var total = 0L
      var n = in.read(buf)
      while (n > 0) {
        var i = 0
        while (i < n) {
          total += (buf(i) & 0xFF).toLong
          i += 1
        }
        n = in.read(buf)
      }
      println(total % 4294967296L)
    } finally {
      in.close()
    }
  }
}
