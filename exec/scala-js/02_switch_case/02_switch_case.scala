// task 02 switch_case — expected output: 7500000075000000
// build: JAVA_HOME=<jdk> tools/scala-cli/scala-cli.exe --power package 02_switch_case.scala --js -o prog.js --force --jvm system    run: tools/nodejs/node.exe prog.js
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
    var acc = 0L
    var i = 0L
    while (i < 100000000L) {
      (i % 4).toInt match {
        case 0 => acc += 1L
        case 1 => acc += i
        case 2 => acc += 2L * i
        case 3 => acc += 3L * i
      }
      i += 1L
    }
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(acc)
  }
}
