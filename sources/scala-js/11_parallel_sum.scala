// task 11 parallel_sum — expected output: 7500000075000000
// build: JAVA_HOME=<jdk> tools/scala-cli/scala-cli.exe --power package 11_parallel_sum.scala --js -o prog.js --force --jvm system    run: tools/nodejs/node.exe prog.js
// note: the Scala.js row; the JVM sibling is sources/scala/. Built with tools/scala-cli/scala-cli.exe
//       (Scala 3.9.0, Scala.js 1.22.0) and run under tools/nodejs/node.exe (node 22.11.0).
// note: <jdk> is the JDK scala-cli itself runs on (jdk-24 here). The build compiles the Scala source
//       to JavaScript and links it into one node-runnable file, so this row's run line is node, not
//       java, and there is no JVM in the measurement.
// note: correct-answer-no-speedup. Scala.js has no java.lang.Thread and this build starts no worker,
//       so the four quarters are computed serially in the caller. The work function, the four fixed
//       ranges and the summation are the JVM row's, so the answer is the same 7500000075000000; only
//       the overlap is missing. Same disposition as the wasm rows whose runtime has no threads.
// note: this is a change from sources/scala/11_parallel_sum.scala, which spawns four
//       java.lang.Threads -- the one thing in the fifteen tasks Scala.js cannot express.

object Main {
  private def work(t: Int, results: Array[Long]): Unit = {
    val start = t.toLong * 25000000L
    val end = start + 25000000L
    var acc = 0L
    var i = start
    while (i < end) {
      (i % 4L).toInt match {
        case 0 => acc += 1L
        case 1 => acc += i
        case 2 => acc += 2L * i
        case 3 => acc += 3L * i
      }
      i += 1L
    }
    results(t) = acc
  }

  def main(args: Array[String]): Unit = {
    val __t0 = System.nanoTime()
    val results = new Array[Long](4)
    var t = 0
    while (t < 4) {
      work(t, results)
      t += 1
    }
    var total = 0L
    t = 0
    while (t < 4) {
      total += results(t)
      t += 1
    }
    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(total)
  }
}
