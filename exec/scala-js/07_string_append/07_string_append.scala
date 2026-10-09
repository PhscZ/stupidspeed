// task 07 string_append — expected output: 250000
// build: JAVA_HOME=<jdk> tools/scala-cli/scala-cli.exe --power package 07_string_append.scala --js -o prog.js --force --jvm system    run: tools/nodejs/node.exe prog.js
// note: the Scala.js row; the JVM sibling is sources/scala/. Built with tools/scala-cli/scala-cli.exe
//       (Scala 3.9.0, Scala.js 1.22.0) and run under tools/nodejs/node.exe (node 22.11.0).
// note: <jdk> is the JDK scala-cli itself runs on (jdk-24 here). The build compiles the Scala source
//       to JavaScript and links it into one node-runnable file, so this row's run line is node, not
//       java, and there is no JVM in the measurement.
// note: the body is the JVM source unchanged. `text + "x"` becomes JavaScript string concatenation,
//       which is where V8's rope/cons-string representation does the work the JVM's StringBuilder
//       would; deliberately no StringBuilder, as in every other row.

object Main {
  def main(args: Array[String]): Unit = {
    val __t0 = System.nanoTime()
    var text = ""
    var i = 0L
    while (i < 250000L) {
      text = text + "x"
      i += 1L
    }
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(text.length)
  }
}
