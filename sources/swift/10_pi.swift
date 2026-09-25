// task 10 pi — expected output: 44889
// build: swiftc -O -o prog 10_pi.swift    run: ./prog

// Gibbons' unbounded spigot, from "Unbounded Spigot Algorithms for the Digits of Pi":
//
//     pi = g(1,0,1,1,3,3) where
//         g(q,r,t,k,n,l) = if 4*q+r-t < n*t
//                          then n : g(10*q, 10*(r-n*t), t, k,
//                                     div (10*(3*q+r)) t - 10*n, l)
//                          else g(q*k, (2*q+r)*l, t*l, k+1,
//                                     div (q*(7*k+2) + r*l) (t*l), l+2)
//
// The Swift standard library has no arbitrary-precision integers, so the state is
// carried in hand-written ones: sign-magnitude, base 10^9 limbs, with
// multiply-by-small and a division whose quotient is known to be small. Only the
// sum of the digits is printed, never the digits themselves.

let BASE: UInt64 = 1_000_000_000

struct Big {
    // Little-endian base-10^9 limbs, normalised: no leading zero limbs.
    var d: [UInt64] = [0]

    init() {}

    init(_ v: UInt64) {
        var x = v
        var limbs: [UInt64] = []
        while x > 0 {
            limbs.append(x % BASE)
            x /= BASE
        }
        d = limbs.isEmpty ? [0] : limbs
    }

    var isZero: Bool { return d.count == 1 && d[0] == 0 }

    mutating func trim() {
        while d.count > 1 && d[d.count - 1] == 0 {
            d.removeLast()
        }
    }

    func cmp(_ other: Big) -> Int {
        if d.count != other.d.count {
            return d.count < other.d.count ? -1 : 1
        }
        var i = d.count - 1
        while i >= 0 {
            if d[i] != other.d[i] {
                return d[i] < other.d[i] ? -1 : 1
            }
            i -= 1
        }
        return 0
    }

    func add(_ other: Big) -> Big {
        let n = d.count > other.d.count ? d.count : other.d.count
        var res = [UInt64](repeating: 0, count: n + 1)
        var carry: UInt64 = 0
        for i in 0..<n {
            let x = (i < d.count ? d[i] : 0) + (i < other.d.count ? other.d[i] : 0) + carry
            res[i] = x % BASE
            carry = x / BASE
        }
        res[n] = carry
        var r = Big()
        r.d = res
        r.trim()
        return r
    }

    // Requires self >= other.
    func sub(_ other: Big) -> Big {
        var res = d
        var borrow: UInt64 = 0
        for i in 0..<res.count {
            let b = i < other.d.count ? other.d[i] : 0
            let x = res[i]
            if x >= b + borrow {
                res[i] = x - b - borrow
                borrow = 0
            } else {
                res[i] = x + BASE - b - borrow
                borrow = 1
            }
        }
        var r = Big()
        r.d = res
        r.trim()
        return r
    }

    // Requires m < 10^9 so that a limb times m plus the carry still fits in 64 bits.
    func mulSmall(_ m: UInt64) -> Big {
        if m == 0 || isZero {
            return Big(0)
        }
        var res = [UInt64](repeating: 0, count: d.count + 1)
        var carry: UInt64 = 0
        for i in 0..<d.count {
            let p = d[i] * m + carry
            res[i] = p % BASE
            carry = p / BASE
        }
        res[d.count] = carry
        var r = Big()
        r.d = res
        r.trim()
        return r
    }

    // Only used on values known to be below 10^18.
    func toUInt64() -> UInt64 {
        var v: UInt64 = 0
        var i = d.count - 1
        while i >= 0 {
            v = v * BASE + d[i]
            i -= 1
        }
        return v
    }

    // floor(self / other). The spigot only ever asks for a digit-extraction
    // quotient, a few hundred at most, so the two-limb estimate below is within a
    // couple of units of the truth and the correction loops run a few times.
    func divMod(_ other: Big) -> (Big, Big) {
        if cmp(other) < 0 {
            return (Big(0), self)
        }
        let la = d.count
        let lb = other.d.count
        var q: UInt64
        if la <= 2 && lb <= 2 {
            q = toUInt64() / other.toUInt64()
        } else {
            let secondA: UInt64 = la >= 2 ? d[la - 2] : 0
            let secondB: UInt64 = lb >= 2 ? other.d[lb - 2] : 0
            let topA = Double(d[la - 1]) * 1e9 + Double(secondA)
            let topB = Double(other.d[lb - 1]) * 1e9 + Double(secondB)
            var scale = 1.0
            var e = la - lb
            while e > 0 {
                scale *= 1e9
                e -= 1
            }
            var est = (topA / topB) * scale
            if est > 1e9 {
                est = 1e9
            }
            if est < 1.0 {
                est = 1.0
            }
            q = UInt64(est)
        }
        while other.mulSmall(q).cmp(self) > 0 {
            q -= 1
        }
        while other.mulSmall(q + 1).cmp(self) <= 0 {
            q += 1
        }
        return (Big(q), sub(other.mulSmall(q)))
    }
}

// Signed wrapper: the spigot's r goes negative, everything else stays positive.
struct Signed {
    var neg: Bool
    var mag: Big

    init(_ m: Big, neg: Bool = false) {
        if m.isZero {
            self.neg = false
            self.mag = m
        } else {
            self.neg = neg
            self.mag = m
        }
    }

    static let zero = Signed(Big(0))

    var isZero: Bool { return mag.isZero }

    func negated() -> Signed {
        return isZero ? self : Signed(mag, neg: !neg)
    }

    func add(_ other: Signed) -> Signed {
        if neg == other.neg {
            return Signed(mag.add(other.mag), neg: neg)
        }
        let c = mag.cmp(other.mag)
        if c == 0 {
            return Signed.zero
        }
        if c > 0 {
            return Signed(mag.sub(other.mag), neg: neg)
        }
        return Signed(other.mag.sub(mag), neg: other.neg)
    }

    func sub(_ other: Signed) -> Signed {
        return add(other.negated())
    }

    func mulSmall(_ m: UInt64) -> Signed {
        return Signed(mag.mulSmall(m), neg: neg)
    }

    func cmp(_ other: Signed) -> Int {
        if neg != other.neg {
            return neg ? -1 : 1
        }
        let c = mag.cmp(other.mag)
        return neg ? -c : c
    }
}

var q = Big(1)
var r = Signed(Big(0))
var t = Big(1)
var n: UInt64 = 3
var k: UInt64 = 1
var l: UInt64 = 3
var digitSum = 0
var produced = 0

while produced < 10000 {
    // 4q + r - t < n t is the same test as 4q + r < (n + 1) t, with both sides
    // non-negative.
    let lhs = Signed(q.mulSmall(4)).add(r)
    let rhs = Signed(t.mulSmall(n + 1))

    if lhs.cmp(rhs) < 0 {
        // The digit n is settled: emit it and scale the state by ten.
        digitSum += Int(n)
        produced += 1

        let threeQR = Signed(q.mulSmall(3)).add(r)                  // 3q + r, never negative
        let (quot, _) = threeQR.mag.mulSmall(10).divMod(t)           // div (10 (3q + r)) t
        let next = quot.toUInt64() - 10 * n

        let nq = q.mulSmall(10)
        let nr = r.sub(Signed(t.mulSmall(n))).mulSmall(10)           // 10 (r - n t)
        q = nq
        r = nr
        n = next
    } else {
        // Not settled yet: widen the state by one more term of the series.
        let num = Signed(q.mulSmall(7 * k + 2)).add(r.mulSmall(l))   // q (7k + 2) + r l
        let nt = t.mulSmall(l)
        let (quot, _) = num.mag.divMod(nt)
        let next = quot.toUInt64()

        let nq = q.mulSmall(k)
        let nr = Signed(q.mulSmall(2)).add(r).mulSmall(l)            // (2q + r) l
        q = nq
        r = nr
        t = nt
        n = next
        k += 1
        l += 2
    }
}

print(digitSum)
