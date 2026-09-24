// task 14 file_read — expected output: 484442112
// build: scalac -release 17 main.scala    run: scala Main
// Reads data.bin (104857600 bytes) from the working directory in 1 MiB chunks.

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
