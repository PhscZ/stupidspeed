// task 02 switch_case — expected output: 7500000075000000
// build: scalac -release 17 main.scala    run: scala Main

object Main {
  def main(args: Array[String]): Unit = {
    var acc = 0L
    var i = 0L
    while (i < 100000000L) {
      (i % 4).toInt match {
        case 0 => acc += 1L
        case 1 => acc += i
        case 2 => acc += 2L * i
        case 3 => acc += 3L * i
      }
      i += 1L
    }
    println(acc)
  }
}
