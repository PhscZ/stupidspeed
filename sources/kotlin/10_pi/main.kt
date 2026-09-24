// task 10 pi — expected output: 44889
// build: kotlinc main.kt -include-runtime -d prog.jar    run: java -jar prog.jar    [native build: kotlinc-native -opt -o prog main.kt    native run: ./prog]
// note: the common Kotlin stdlib has no big integers (java.math is JVM-only), so this is a hand-written base-10^9 limb bignum: multiply by a small int, add/subtract, and divide by a big divisor whose quotient is a small int. Gibbons' unbounded spigot.

private const val BASE = 1000000000L

private fun magCmp(a: LongArray, al: Int, b: LongArray, bl: Int): Int {
    if (al != bl) return if (al > bl) 1 else -1
    var i = al - 1
    while (i >= 0) {
        if (a[i] != b[i]) return if (a[i] > b[i]) 1 else -1
        i--
    }
    return 0
}

// Signed arbitrary-precision integer, little-endian base-10^9 limbs in mag[0 until len].
private class Big {
    var neg = false
    var mag = LongArray(4)
    var len = 0

    private fun grow(n: Int) {
        var cap = mag.size
        while (cap < n) cap *= 2
        val a = LongArray(cap)
        mag.copyInto(a, 0, 0, len)
        mag = a
    }

    private fun trim() {
        while (len > 0 && mag[len - 1] == 0L) len--
        if (len == 0) neg = false
    }

    fun setLong(v: Long) {
        var x = v
        neg = x < 0L
        if (neg) x = -x
        var i = 0
        while (x > 0L) {
            if (i == mag.size) grow(i + 1)
            mag[i] = x % BASE
            x /= BASE
            i++
        }
        len = i
        if (len == 0) neg = false
    }

    fun set(o: Big) {
        if (mag.size < o.len) grow(o.len)
        o.mag.copyInto(mag, 0, 0, o.len)
        len = o.len
        neg = o.neg
    }

    fun setMulSmall(o: Big, m: Long) {
        if (o.len == 0 || m == 0L) {
            len = 0
            neg = false
            return
        }
        var mm = m
        neg = o.neg
        if (mm < 0L) {
            neg = !neg
            mm = -mm
        }
        if (mag.size < o.len + 1) grow(o.len + 1)
        var carry = 0L
        var i = 0
        while (i < o.len) {
            val p = o.mag[i] * mm + carry
            mag[i] = p % BASE
            carry = p / BASE
            i++
        }
        len = o.len
        while (carry > 0L) {
            if (len == mag.size) grow(len + 1)
            mag[len] = carry % BASE
            carry /= BASE
            len++
        }
    }

    fun mulSmall(m: Long) {
        if (len == 0 || m == 0L) {
            len = 0
            neg = false
            return
        }
        var mm = m
        if (mm < 0L) {
            neg = !neg
            mm = -mm
        }
        if (mm == 1L) return
        var carry = 0L
        var i = 0
        while (i < len) {
            val p = mag[i] * mm + carry
            mag[i] = p % BASE
            carry = p / BASE
            i++
        }
        while (carry > 0L) {
            if (len == mag.size) grow(len + 1)
            mag[len] = carry % BASE
            carry /= BASE
            len++
        }
    }

    fun cmp(o: Big): Int {
        if (neg != o.neg) return if (neg) -1 else 1
        val c = magCmp(mag, len, o.mag, o.len)
        return if (neg) -c else c
    }

    // this += |o|, sign unchanged
    private fun addMag(o: Big) {
        var carry = 0L
        val n = if (len > o.len) len else o.len
        if (mag.size < n + 1) grow(n + 1)
        var i = 0
        while (i < n) {
            val a = if (i < len) mag[i] else 0L
            val b = if (i < o.len) o.mag[i] else 0L
            var s = a + b + carry
            if (s >= BASE) {
                s -= BASE
                carry = 1L
            } else {
                carry = 0L
            }
            mag[i] = s
            i++
        }
        len = n
        if (carry != 0L) {
            mag[len] = carry
            len++
        }
    }

    // this -= o, requires |this| > |o|; sign unchanged
    private fun subMagLow(o: Big) {
        var borrow = 0L
        var i = 0
        while (i < len) {
            val b = if (i < o.len) o.mag[i] else 0L
            var d = mag[i] - b - borrow
            if (d < 0L) {
                d += BASE
                borrow = 1L
            } else {
                borrow = 0L
            }
            mag[i] = d
            i++
        }
        trim()
    }

    // this := |o| - |this|, requires |o| > |this|
    private fun subMagHigh(o: Big) {
        if (mag.size < o.len) grow(o.len)
        var borrow = 0L
        var i = 0
        while (i < o.len) {
            val a = if (i < len) mag[i] else 0L
            var d = o.mag[i] - a - borrow
            if (d < 0L) {
                d += BASE
                borrow = 1L
            } else {
                borrow = 0L
            }
            mag[i] = d
            i++
        }
        len = o.len
        trim()
    }

    fun addAssign(o: Big) {
        if (o.len == 0) return
        if (len == 0) {
            set(o)
            return
        }
        if (neg == o.neg) {
            addMag(o)
            return
        }
        val c = magCmp(mag, len, o.mag, o.len)
        if (c == 0) {
            len = 0
            neg = false
        } else if (c > 0) {
            subMagLow(o)
        } else {
            subMagHigh(o)
            neg = o.neg
        }
    }

    fun subAssign(o: Big) {
        if (o.len == 0) return
        if (len == 0) {
            set(o)
            neg = !neg
            return
        }
        if (neg != o.neg) {
            addMag(o)
            return
        }
        val c = magCmp(mag, len, o.mag, o.len)
        if (c == 0) {
            len = 0
            neg = false
        } else if (c > 0) {
            subMagLow(o)
        } else {
            subMagHigh(o)
            neg = !neg
        }
    }
}

// floor(num / den) as a Long, with den > 0. The quotient is a small integer here, so a
// doubling search plus a binary search is enough and stays exact.
private fun divFloor(num: Big, den: Big, prod: Big): Long {
    if (num.len == 0) return 0L
    val negNum = num.neg
    if (negNum) num.neg = false
    var q = 0L
    if (num.cmp(den) >= 0) {
        var hi = 1L
        prod.setMulSmall(den, hi)
        while (num.cmp(prod) >= 0) {
            hi *= 2L
            prod.setMulSmall(den, hi)
        }
        var lo = hi / 2L
        while (lo + 1L < hi) {
            val mid = (lo + hi) / 2L
            prod.setMulSmall(den, mid)
            if (num.cmp(prod) >= 0) lo = mid else hi = mid
        }
        q = lo
    }
    if (negNum) {
        prod.setMulSmall(den, q)
        if (num.cmp(prod) != 0) q += 1L
        q = -q
        num.neg = true
    }
    return q
}

fun main() {
    // Gibbons' unbounded spigot: (q, r, t, k, n, l), n is the digit produced when safe.
    val q = Big()
    q.setLong(1L)
    val r = Big()
    r.setLong(0L)
    val t = Big()
    t.setLong(1L)
    var k = 1L
    var n = 3L
    var l = 3L

    val lhs = Big()
    val rhs = Big()
    val num = Big()
    val den = Big()
    val prod = Big()
    val tmp = Big()

    var digits = 0
    var sum = 0L
    while (digits < 10000) {
        // 4*q + r - t < n*t  means the digit n is safe to emit
        lhs.setMulSmall(q, 4L)
        lhs.addAssign(r)
        lhs.subAssign(t)
        rhs.setMulSmall(t, n)
        if (lhs.cmp(rhs) < 0) {
            sum += n
            digits++
            // n = div(10*(3*q + r), t) - 10*n ; q = 10*q ; r = 10*(r - n*t)
            num.setMulSmall(q, 3L)
            num.addAssign(r)
            num.mulSmall(10L)
            val next = divFloor(num, t, prod) - 10L * n
            tmp.setMulSmall(t, n)
            r.subAssign(tmp)
            r.mulSmall(10L)
            q.mulSmall(10L)
            n = next
        } else {
            // q = q*k ; r = (2*q + r)*l ; t = t*l ; n = div(q*(7*k + 2) + r*l, t*l)
            den.setMulSmall(t, l)
            num.setMulSmall(r, l)
            tmp.setMulSmall(q, 7L * k + 2L)
            num.addAssign(tmp)
            n = divFloor(num, den, prod)
            tmp.setMulSmall(q, 2L)
            tmp.addAssign(r)
            tmp.mulSmall(l)
            r.set(tmp)
            q.mulSmall(k)
            t.set(den)
            k += 1L
            l += 2L
        }
    }
    println(sum)
}
