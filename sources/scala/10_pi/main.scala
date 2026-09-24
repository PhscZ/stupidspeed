// task 10 pi — expected output: 44889
// build: scalac -release 17 main.scala    run: scala Main
// Gibbons' unbounded spigot on java.math.BigInteger; the first 10000 digits it emits are
// summed, and that includes the leading 3. The digits themselves are never printed.

import java.math.BigInteger

object Main {
  private val Zero = BigInteger.ZERO
  private val One = BigInteger.ONE
  private val Ten = BigInteger.TEN

  // Floor division, so that negative intermediates divide exactly as the reference `//` does.
  private def floorDiv(a: BigInteger, b: BigInteger): BigInteger = {
    val q = a.divide(b)
    if (a.signum() < 0 && a.remainder(b).signum() != 0) q.subtract(One) else q
  }

  def main(args: Array[String]): Unit = {
    var q = One
    var r = Zero
    var t = One
    var k = 1L
    var n = 3L
    var l = 3L
    var digits = 0
    var sum = 0L

    while (digits < 10000) {
      val nTimesT = t.multiply(BigInteger.valueOf(n))
      if (q.shiftLeft(2).add(r).subtract(t).compareTo(nTimesT) < 0) {
        // emit n, then (q,r,t,k,n,l) = (10q, 10(r-nt), t, k, (10(3q+r))/t - 10n, l)
        sum += n
        digits += 1
        val rNext = r.subtract(nTimesT).multiply(Ten)
        val nNext = floorDiv(q.multiply(BigInteger.valueOf(3L)).add(r).multiply(Ten), t)
          .subtract(BigInteger.valueOf(10L * n))
        q = q.multiply(Ten)
        r = rNext
        n = nNext.longValueExact()
      } else {
        // (q,r,t,k,n,l) = (qk, (2q+r)l, tl, k+1, (q(7k+2)+rl)/(tl), l+2)
        val kBig = BigInteger.valueOf(k)
        val lBig = BigInteger.valueOf(l)
        val rNext = q.multiply(BigInteger.valueOf(2L)).add(r).multiply(lBig)
        val tNext = t.multiply(lBig)
        val num = q.multiply(BigInteger.valueOf(7L * k + 2L)).add(r.multiply(lBig))
        val nNext = floorDiv(num, tNext)
        q = q.multiply(kBig)
        r = rNext
        t = tNext
        k = k + 1L
        n = nNext.longValueExact()
        l = l + 2L
      }
    }

    println(sum)
  }
}
