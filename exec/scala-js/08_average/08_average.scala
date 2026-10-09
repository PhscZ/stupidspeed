// task 08 average — expected output: 0.498046875
// build: JAVA_HOME=<jdk> tools/scala-cli/scala-cli.exe --power package 08_average.scala --js -o prog.js --force --jvm system    run: tools/nodejs/node.exe prog.js
// note: the Scala.js row; the JVM sibling is sources/scala/. Built with tools/scala-cli/scala-cli.exe
//       (Scala 3.9.0, Scala.js 1.22.0) and run under tools/nodejs/node.exe (node 22.11.0).
// note: <jdk> is the JDK scala-cli itself runs on (jdk-24 here). The build compiles the Scala source
//       to JavaScript and links it into one node-runnable file, so this row's run line is node, not
//       java, and there is no JVM in the measurement.
// note: the body is the JVM source unchanged; a Double is JavaScript's number, so the hundred million
//       additions and the final division are the same IEEE-754 doubles the JVM row uses.

object Main {
  def main(args: Array[String]): Unit = {
    val __t0 = System.nanoTime()
    var total = 0.0
    var i = 0L
    while (i < 100000000L) {
      val reading = (i % 256L).toDouble / 256.0
      total += reading
      i += 1L
    }
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(total / 100000000.0)
  }
}
