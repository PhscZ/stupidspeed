// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: scalac -release 17 01_branches.scala    run: scala Main

object Main {
  def main(args: Array[String]): Unit = {
    var a = 0L
    var b = 0L
    var c = 0L
    var d = 0L
    var i = 0L
    while (i < 100000000L) {
      if (i % 3 == 0) a += 1L
      else if (i % 5 == 0) b += 1L
      else if (i % 7 == 0) c += 1L
      else d += 1L
      i += 1L
    }
    println(s"$a $b $c $d")
  }
}
