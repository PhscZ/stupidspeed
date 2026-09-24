// task 15 file_write — expected output: 104857600
// build: scalac -release 17 15_file_write.scala    run: scala Main
// Writes out.bin as 100 chunks of the 1 MiB pattern 0,1,2,...,255 repeated 4096 times.

import java.io.FileOutputStream

object Main {
  def main(args: Array[String]): Unit = {
    val buf = new Array[Byte](1024 * 1024)
    var i = 0
    while (i < buf.length) {
      buf(i) = (i % 256).toByte
      i += 1
    }

    val out = new FileOutputStream("out.bin")
    try {
      var written = 0L
      var rep = 0
      while (rep < 100) {
        out.write(buf)
        written += buf.length.toLong
        rep += 1
      }
      out.flush()
      out.getFD.sync()
      println(written)
    } finally {
      out.close()
    }
  }
}
