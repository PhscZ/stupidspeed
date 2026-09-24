// task 13 matrix_mul — expected output: 599995000
// build: scalac -release 17 main.scala    run: scala Main

object Main {
  def main(args: Array[String]): Unit = {
    val n = 500
    val size = n * n
    val a = new Array[Long](size)
    val b = new Array[Long](size)
    val c = new Array[Long](size)

    var i = 0
    while (i < n) {
      var j = 0
      while (j < n) {
        a(i * n + j) = ((i + j) % 7).toLong
        j += 1
      }
      i += 1
    }

    i = 0
    while (i < n) {
      var j = 0
      while (j < n) {
        b(i * n + j) = ((i * j) % 5).toLong
        j += 1
      }
      i += 1
    }

    i = 0
    while (i < n) {
      var j = 0
      while (j < n) {
        var sum = 0L
        var k = 0
        while (k < n) {
          sum += a(i * n + k) * b(k * n + j)
          k += 1
        }
        c(i * n + j) = sum
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
