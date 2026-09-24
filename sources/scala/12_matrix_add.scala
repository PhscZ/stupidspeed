// task 12 matrix_add — expected output: 999000000
// build: scalac -release 17 12_matrix_add.scala    run: scala Main

object Main {
  def main(args: Array[String]): Unit = {
    val n = 1000
    val size = n * n
    val a = new Array[Long](size)
    val b = new Array[Long](size)
    val c = new Array[Long](size)

    var i = 0
    while (i < n) {
      var j = 0
      while (j < n) {
        a(i * n + j) = (i + j).toLong
        j += 1
      }
      i += 1
    }

    i = 0
    while (i < n) {
      var j = 0
      while (j < n) {
        b(i * n + j) = (i - j).toLong
        j += 1
      }
      i += 1
    }

    i = 0
    while (i < n) {
      var j = 0
      while (j < n) {
        c(i * n + j) = a(i * n + j) + b(i * n + j)
        j += 1
      }
      i += 1
    }

    var total = 0L
    i = 0
    while (i < size) {
      total += c(i)
      i += 1
    }
    println(total)
  }
}
