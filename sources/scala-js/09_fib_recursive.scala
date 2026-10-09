// task 09 fib_recursive — expected output: 102334155
// build: JAVA_HOME=<jdk> tools/scala-cli/scala-cli.exe --power package 09_fib_recursive.scala --js -o prog.js --force --jvm system    run: tools/nodejs/node.exe prog.js
// note: the Scala.js row; the JVM sibling is sources/scala/. Built with tools/scala-cli/scala-cli.exe
//       (Scala 3.9.0, Scala.js 1.22.0) and run under tools/nodejs/node.exe (node 22.11.0).
// note: <jdk> is the JDK scala-cli itself runs on (jdk-24 here). The build compiles the Scala source
//       to JavaScript and links it into one node-runnable file, so this row's run line is node, not
//       java, and there is no JVM in the measurement.
// note: the body is the JVM source unchanged. fib(40) is 331 million calls, so what is measured is
//       JavaScript's call path: there is no JIT tier above V8's own to make the recursion cheap.

object Main {
  private def fib(n: Long): Long =
    if (n < 2L) n else fib(n - 1L) + fib(n - 2L)

  def main(args: Array[String]): Unit = {
    val __t0 = System.nanoTime()
    val answer = fib(40L)
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(answer)
  }
}
