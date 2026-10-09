// task 12 matrix_add — expected output: 999000000
// build: JAVA_HOME=<jdk> tools/scala-cli/scala-cli.exe --power package 12_matrix_add.scala --js -o prog.js --force --jvm system    run: tools/nodejs/node.exe prog.js
// note: the Scala.js row; the JVM sibling is sources/scala/. Built with tools/scala-cli/scala-cli.exe
//       (Scala 3.9.0, Scala.js 1.22.0) and run under tools/nodejs/node.exe (node 22.11.0).
// note: <jdk> is the JDK scala-cli itself runs on (jdk-24 here). The build compiles the Scala source
//       to JavaScript and links it into one node-runnable file, so this row's run line is node, not
//       java, and there is no JVM in the measurement.
// note: the body is the JVM source unchanged; the three flat matrices are Scala.js LongArrays and the
//       index arithmetic is the same.

object Main {
  def main(args: Array[String]): Unit = {
    val __t0 = System.nanoTime()
    val n = 1000
    val size = n * n
    val a = new Array[Long](size)
    val b = new Array[Long](size)
    val c = new Array[Long](size)

    var i = 0
    while (i < n) {
      var j = 0
      while (j < n) {
        a(i * n + j) = (i + j).toLong
        j += 1
      }
      i += 1
    }

    i = 0
    while (i < n) {
      var j = 0
      while (j < n) {
        b(i * n + j) = (i - j).toLong
        j += 1
      }
      i += 1
    }

    i = 0
    while (i < n) {
      var j = 0
      while (j < n) {
        c(i * n + j) = a(i * n + j) + b(i * n + j)
        j += 1
      }
      i += 1
    }

    var total = 0L
    i = 0
    while (i < size) {
      total += c(i)
      i += 1
    }
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(total)
  }
}
