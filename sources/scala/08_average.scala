// task 08 average — expected output: 0.498046875
// build: scalac -release 17 08_average.scala    run: scala Main

object Main {
  def main(args: Array[String]): Unit = {
    var total = 0.0
    var i = 0L
    while (i < 100000000L) {
      val reading = (i % 256L).toDouble / 256.0
      total += reading
      i += 1L
    }
    println(total / 100000000.0)
  }
}
