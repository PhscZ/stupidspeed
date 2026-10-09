// task 03 func_sum — expected output: 100000000
// build: JAVA_HOME=<jdk> tools/scala-cli/scala-cli.exe --power package 03_func_sum.scala --js -o prog.js --force --jvm system    run: tools/nodejs/node.exe prog.js
// note: the Scala.js row; the JVM sibling is sources/scala/. Built with tools/scala-cli/scala-cli.exe
//       (Scala 3.9.0, Scala.js 1.22.0) and run under tools/nodejs/node.exe (node 22.11.0).
// note: <jdk> is the JDK scala-cli itself runs on (jdk-24 here). The build compiles the Scala source
//       to JavaScript and links it into one node-runnable file, so this row's run line is node, not
//       java, and there is no JVM in the measurement.
// note: the body is the JVM source unchanged; Scala.js implements the scala-library and java.lang
//       surface these tasks use, System.nanoTime included.
// note: @noinline is scala.noinline (auto-imported); it stops the Scala.js optimiser's inliner, which
//       is the only inliner above the emitted JavaScript. There is no second JIT to undo it.

object Main {
  @noinline private def addOne(n: Long): Long = n + 1L

  def main(args: Array[String]): Unit = {
    val __t0 = System.nanoTime()
    var value = 0L
    var i = 0L
    while (i < 100000000L) {
      value = addOne(value)
      i += 1L
    }
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(value)
  }
}
