// task 14 file_read — expected output: 2389704704
// build: JAVA_HOME=<jdk> tools/scala-cli/scala-cli.exe --power package 14_file_read.scala --js -o prog.js --force --jvm system    run: tools/nodejs/node.exe prog.js
// note: the Scala.js row; the JVM sibling is sources/scala/. Built with tools/scala-cli/scala-cli.exe
//       (Scala 3.9.0, Scala.js 1.22.0) and run under tools/nodejs/node.exe (node 22.11.0).
// note: <jdk> is the JDK scala-cli itself runs on (jdk-24 here). The build compiles the Scala source
//       to JavaScript and links it into one node-runnable file, so this row's run line is node, not
//       java, and there is no JVM in the measurement.
// note: this is a change from sources/scala/14_file_read.scala. Scala.js's javalib has no file system
//       at all, so java.io.FileInputStream does not exist here; the file is reached through node's fs
//       module instead, via scala.scalajs.js.Dynamic.global.require("fs"), which the Scala.js linker
//       emits as a plain require("fs") call inside the node module. openSync/readSync/closeSync are
//       the same open/read/close sequence, in the same 1 MiB chunks, and the running total is the
//       same sum of the same bytes reduced mod 2^32.
// note: node has no text mode: readSync fills a Uint8Array with the raw bytes and no BOM is stripped
//       or added, so the scan sees the same 0..255 values the JVM row masks out of its signed bytes.
// Reads data.bin (52428800 bytes) from the working directory in 1 MiB chunks.

import scala.scalajs.js
import scala.scalajs.js.typedarray.Uint8Array

object Main {
  def main(args: Array[String]): Unit = {
    val __t0 = System.nanoTime()
    val fs = js.Dynamic.global.require("fs")
    val fd = fs.openSync("data.bin", "r").asInstanceOf[Int]
    try {
      val buf = new Uint8Array(1024 * 1024)
      var total = 0L
      var n = fs.readSync(fd, buf, 0, buf.length, null).asInstanceOf[Int]
      while (n > 0) {
        var i = 0
        while (i < n) {
          total += (buf(i) & 0xFF).toLong
          i += 1
        }
        n = fs.readSync(fd, buf, 0, buf.length, null).asInstanceOf[Int]
      }
      System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
      println(total % 4294967296L)
    } finally {
      fs.closeSync(fd)
    }
  }
}
