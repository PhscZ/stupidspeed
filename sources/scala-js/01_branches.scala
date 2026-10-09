// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: JAVA_HOME=<jdk> tools/scala-cli/scala-cli.exe --power package 01_branches.scala --js -o prog.js --force --jvm system    run: tools/nodejs/node.exe prog.js
// note: the Scala.js row; the JVM sibling is sources/scala/. Built with tools/scala-cli/scala-cli.exe
//       (Scala 3.9.0, Scala.js 1.22.0) and run under tools/nodejs/node.exe (node 22.11.0).
// note: <jdk> is the JDK scala-cli itself runs on (jdk-24 here). The build compiles the Scala source
//       to JavaScript and links it into one node-runnable file, so this row's run line is node, not
//       java, and there is no JVM in the measurement.
// note: the body is the JVM source unchanged; Scala.js implements the scala-library and java.lang
//       surface these tasks use, System.nanoTime included.

object Main {
  def main(args: Array[String]): Unit = {
    val __t0 = System.nanoTime()
    var a = 0L
    var b = 0L
    var c = 0L
    var d = 0L
    var i = 0L
    while (i < 100000000L) {
      if (i % 3 == 0) a += 1L
      else if (i % 5 == 0) b += 1L
      else if (i % 7 == 0) c += 1L
      else d += 1L
      i += 1L
    }
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(s"$a $b $c $d")
  }
}
