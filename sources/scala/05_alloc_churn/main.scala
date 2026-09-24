// task 05 alloc_churn — expected output: 1274991808
// build: scalac -release 17 main.scala    run: scala Main

object Main {
  def main(args: Array[String]): Unit = {
    var total = 0L
    val slots = new Array[Array[Byte]](256)
    var i = 0L
    while (i < 10000000L) {
      val buf = new Array[Byte](64)
      buf(0) = (i % 256L).toByte
      total += (buf(0) & 0xFF).toLong
      slots((i % 256L).toInt) = buf
      i += 1L
    }
    println(total)
  }
}
