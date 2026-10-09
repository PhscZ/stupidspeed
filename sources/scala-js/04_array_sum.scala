// task 04 array_sum — expected output: 499999500000
// build: JAVA_HOME=<jdk> tools/scala-cli/scala-cli.exe --power package 04_array_sum.scala --js -o prog.js --force --jvm system    run: tools/nodejs/node.exe prog.js
// note: the Scala.js row; the JVM sibling is sources/scala/. Built with tools/scala-cli/scala-cli.exe
//       (Scala 3.9.0, Scala.js 1.22.0) and run under tools/nodejs/node.exe (node 22.11.0).
// note: <jdk> is the JDK scala-cli itself runs on (jdk-24 here). The build compiles the Scala source
//       to JavaScript and links it into one node-runnable file, so this row's run line is node, not
//       java, and there is no JVM in the measurement.
// note: the body is the JVM source unchanged. `new Array[Long]` is a Scala.js LongArray, the
//       specialised array the Scala.js runtime provides for Long; it is a real array either way.

object Main {
  def main(args: Array[String]): Unit = {
    val __t0 = System.nanoTime()
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
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(total)
  }
}
