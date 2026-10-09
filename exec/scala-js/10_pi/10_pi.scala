// task 10 pi — expected output: 4470
// build: JAVA_HOME=<jdk> tools/scala-cli/scala-cli.exe --power package 10_pi.scala --js -o prog.js --force --jvm system    run: tools/nodejs/node.exe prog.js
// note: the Scala.js row; the JVM sibling is sources/scala/. Built with tools/scala-cli/scala-cli.exe
//       (Scala 3.9.0, Scala.js 1.22.0) and run under tools/nodejs/node.exe (node 22.11.0).
// note: <jdk> is the JDK scala-cli itself runs on (jdk-24 here). The build compiles the Scala source
//       to JavaScript and links it into one node-runnable file, so this row's run line is node, not
//       java, and there is no JVM in the measurement.
// note: the body is the JVM source unchanged. java.math.BigInteger is part of Scala.js's javalib --
//       a pure-Scala implementation, so unlike the JavaScript row this one does not need to hand-roll
//       limbs or reach for BigInt. Every method the spigot uses is there: valueOf, add, subtract,
//       multiply, divide, remainder, signum, compareTo, shiftLeft, longValueExact and the THREE
//       constants. The measured work is Scala.js's own bignum arithmetic.
// Gibbons' unbounded spigot on java.math.BigInteger; the first 1000 digits it emits are
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
    val __t0 = System.nanoTime()
    var q = One
    var r = Zero
    var t = One
    var k = 1L
    var n = 3L
    var l = 3L
    var digits = 0
    var sum = 0L

    while (digits < 1000) {
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

    System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
    println(sum)
  }
}
