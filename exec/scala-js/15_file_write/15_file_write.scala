// task 15 file_write — expected output: 52428800
// build: JAVA_HOME=<jdk> tools/scala-cli/scala-cli.exe --power package 15_file_write.scala --js -o prog.js --force --jvm system    run: tools/nodejs/node.exe prog.js
// note: the Scala.js row; the JVM sibling is sources/scala/. Built with tools/scala-cli/scala-cli.exe
//       (Scala 3.9.0, Scala.js 1.22.0) and run under tools/nodejs/node.exe (node 22.11.0).
// note: <jdk> is the JDK scala-cli itself runs on (jdk-24 here). The build compiles the Scala source
//       to JavaScript and links it into one node-runnable file, so this row's run line is node, not
//       java, and there is no JVM in the measurement.
// note: this is a change from sources/scala/15_file_write.scala. Scala.js's javalib has no file system
//       at all, so java.io.FileOutputStream does not exist here; the file is reached through node's fs
//       module instead, via scala.scalajs.js.Dynamic.global.require("fs"), which the Scala.js linker
//       emits as a plain require("fs") call inside the node module. openSync/writeSync/fsyncSync/
//       closeSync write the same 1 MiB pattern 50 times and commit it the way getFD().sync() does.
// note: openSync's "w" flag is binary in node -- there is no text mode, so no BOM and no newline
//       translation can be added to the bytes, and fsyncSync is a real fsync on the same fd.
// note: Scala.js's typed-array API types a Uint8Array's elements as Short, so the pattern write is
//       (i % 256).toShort -- the same 0..255 byte values, just the coerced element type.
// Writes out.bin as 50 chunks of the 1 MiB pattern 0,1,2,...,255 repeated 4096 times.

import scala.scalajs.js
import scala.scalajs.js.typedarray.Uint8Array

object Main {
  def main(args: Array[String]): Unit = {
    val __t0 = System.nanoTime()
    val fs = js.Dynamic.global.require("fs")
    val buf = new Uint8Array(1024 * 1024)
    var i = 0
    while (i < buf.length) {
      buf(i) = (i % 256).toShort
      i += 1
    }

    val fd = fs.openSync("out.bin", "w").asInstanceOf[Int]
    try {
      var written = 0L
      var rep = 0
      while (rep < 50) {
        fs.writeSync(fd, buf, 0, buf.length)
        written += buf.length.toLong
        rep += 1
      }
      fs.fsyncSync(fd)
      System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
      println(written)
    } finally {
      fs.closeSync(fd)
    }
  }
}
