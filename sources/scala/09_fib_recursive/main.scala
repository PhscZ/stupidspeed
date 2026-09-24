// task 09 fib_recursive — expected output: 102334155
// build: scalac -release 17 main.scala    run: scala Main

object Main {
  private def fib(n: Long): Long =
    if (n < 2L) n else fib(n - 1L) + fib(n - 2L)

  def main(args: Array[String]): Unit = {
    println(fib(40L))
  }
}
