// task 03 func_sum — expected output: 100000000
// build: scalac -release 17 main.scala    run: scala Main
// @noinline is scala.noinline (auto-imported); it stops the Scala inliner. The JVM JIT may still inline the call at run time.

object Main {
  @noinline private def addOne(n: Long): Long = n + 1L

  def main(args: Array[String]): Unit = {
    var value = 0L
    var i = 0L
    while (i < 100000000L) {
      value = addOne(value)
      i += 1L
    }
    println(value)
  }
}
