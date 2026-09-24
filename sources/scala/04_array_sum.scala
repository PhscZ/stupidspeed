// task 04 array_sum — expected output: 499999500000
// build: scalac -release 17 04_array_sum.scala    run: scala Main

object Main {
  def main(args: Array[String]): Unit = {
    val array = new Array[Long](1000000)
    var i = 0
    while (i < 1000000) {
      array(i) = i.toLong
      i += 1
    }
    var total = 0L
    i = 0
    while (i < 1000000) {
      total += array(i)
      i += 1
    }
    println(total)
  }
}
