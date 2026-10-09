// task 06 char_count — expected output: 10000000
// build: JAVA_HOME=<jdk> tools/scala-cli/scala-cli.exe --power package 06_char_count.scala --js -o prog.js --force --jvm system    run: tools/nodejs/node.exe prog.js
// note: the Scala.js row; the JVM sibling is sources/scala/. Built with tools/scala-cli/scala-cli.exe
//       (Scala 3.9.0, Scala.js 1.22.0) and run under tools/nodejs/node.exe (node 22.11.0).
// note: <jdk> is the JDK scala-cli itself runs on (jdk-24 here). The build compiles the Scala source
//       to JavaScript and links it into one node-runnable file, so this row's run line is node, not
//       java, and there is no JVM in the measurement.
// note: the body is the JVM source unchanged. `"abcdefghij" * 10000000` is scala-library's
//       StringOps.*, so the 100 MB string is built the same way it is on the JVM, and charAt is
//       String.prototype.charAt underneath.

object Main {
  def main(args: Array[String]): Unit = {
    val __t0 = System.nanoTime()
    val text = "abcdefghij" * 10000000
    var count = 0L
    var i = 0
    val len = text.length
    while (i < len) {
      val ch = text.charAt(i)
      if (ch == 'a') ()
      else if (ch == 'e') ()
      else if (ch == 'h') count += 1L
      else ()
      i += 1
    }
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(count)
  }
}
