// task 05 alloc_churn — expected output: 1274991808
// build: JAVA_HOME=<jdk> tools/scala-cli/scala-cli.exe --power package 05_alloc_churn.scala --js -o prog.js --force --jvm system    run: tools/nodejs/node.exe prog.js
// note: the Scala.js row; the JVM sibling is sources/scala/. Built with tools/scala-cli/scala-cli.exe
//       (Scala 3.9.0, Scala.js 1.22.0) and run under tools/nodejs/node.exe (node 22.11.0).
// note: <jdk> is the JDK scala-cli itself runs on (jdk-24 here). The build compiles the Scala source
//       to JavaScript and links it into one node-runnable file, so this row's run line is node, not
//       java, and there is no JVM in the measurement.
// note: the body is the JVM source unchanged. `new Array[Byte]` is a Scala.js ByteArray, backed by a
//       Uint8Array; the 256-slot slot table keeps the same reachability line, and the ten million
//       dead buffers are what V8's generational collector reclaims.

object Main {
  def main(args: Array[String]): Unit = {
    val __t0 = System.nanoTime()
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
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(total)
  }
}
