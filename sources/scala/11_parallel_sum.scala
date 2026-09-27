// task 11 parallel_sum — expected output: 7500000075000000
// build: scalac -release 17 -d out 11_parallel_sum.scala
// run: java -cp "out;<scala>/maven2/org/scala-lang/scala3-library_3/<v>/scala3-library_3-<v>.jar;<scala>/maven2/org/scala-lang/scala-library/<v>/scala-library-<v>.jar" Main
// note: <scala> is the Scala distribution and <v> its version, 3.9.0 for the one this row was
//       measured with. Scala CLI's `scala` is a subcommand runner, so `scala Main` is not a
//       command it accepts; running the compiled class directly with `java -cp` is the
//       equivalent, and it keeps the JVM's own start-up out of the compiler's way.

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
    val results = new Array[Long](4)
    val threads = new Array[Thread](4)
    var t = 0
    while (t < 4) {
      val idx = t
      threads(t) = new Thread(new Runnable {
        def run(): Unit = work(idx, results)
      })
      t += 1
    }
    t = 0
    while (t < 4) {
      threads(t).start()
      t += 1
    }
    t = 0
    while (t < 4) {
      threads(t).join()
      t += 1
    }
    var total = 0L
    t = 0
    while (t < 4) {
      total += results(t)
      t += 1
    }
    println(total)
  }
}
