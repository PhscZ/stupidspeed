// task 10 pi — expected output: 4470
// build: haxe -cp sources/haxe -main T10_pi -cpp temp/haxe/10_pi -D mingw -D MINGW_ROOT=<mingw root> -D no_shared_libs
// run: temp/haxe/10_pi/T10_pi.exe
// note: the Haxe standard library has no arbitrary-precision integer — the widest type is
//       haxe.Int64 — so the spigot state is the same hand-written sign-magnitude little-endian
//       base-1e9 big integer as the C row's, with the same four operations (add, subtract,
//       multiply by a small integer, quotient by repeated subtraction) in the same order.
// note: the limbs are `Int` (a limb is below 1e9, inside the 32-bit range) and the products
//       are haxe.Int64, which on cpp is a native 64-bit integer. A limb times the largest
//       multiplier the spigot uses is about 2.4e12, far inside the 64-bit range.
// note: the digits themselves are never printed, only their sum.

class Big {
    static inline var BASE = 1000000000;
    static var BASE64 = haxe.Int64.ofInt(1000000000);

    public var limb:Array<Int>;   // little-endian, base 1e9
    public var n:Int;             // limb count, no leading zero limbs
    public var neg:Bool;

    public function new() {
        limb = new Array<Int>();
        n = 0;
        neg = false;
    }

    public function reserve(need:Int):Void {
        while (limb.length < need) {
            limb.push(0);
        }
    }

    public function trim():Void {
        while (n > 0 && limb[n - 1] == 0) {
            n--;
        }
        if (n == 0) {
            neg = false;
        }
    }

    public function set(v:haxe.Int64):Void {
        n = 0;
        neg = false;
        while (v > 0) {
            reserve(n + 1);
            limb[n++] = haxe.Int64.toInt(v % BASE64);
            v = v / BASE64;
        }
    }

    public function copyFrom(src:Big):Void {
        reserve(src.n);
        for (i in 0...src.n) {
            limb[i] = src.limb[i];
        }
        n = src.n;
        neg = src.neg;
    }

    public function cmpMag(b:Big):Int {
        if (n != b.n) {
            return n < b.n ? -1 : 1;
        }
        var i = n;
        while (i-- > 0) {
            if (limb[i] != b.limb[i]) {
                return limb[i] < b.limb[i] ? -1 : 1;
            }
        }
        return 0;
    }

    public function cmp(b:Big):Int {
        if (neg != b.neg) {
            return neg ? -1 : 1;
        }
        var c = cmpMag(b);
        return neg ? -c : c;
    }

    public function addMag(r:Big, b:Big):Void {
        var count = n > b.n ? n : b.n;
        r.reserve(count + 1);
        var carry = 0;
        for (i in 0...count) {
            var s = carry;
            if (i < n) {
                s += limb[i];
            }
            if (i < b.n) {
                s += b.limb[i];
            }
            if (s >= BASE) {
                s -= BASE;
                carry = 1;
            } else {
                carry = 0;
            }
            r.limb[i] = s;
        }
        r.limb[count] = carry;
        r.n = count + (carry != 0 ? 1 : 0);
        r.neg = false;
    }

    public function subMag(r:Big, b:Big):Void {   // requires this >= b >= 0
        r.reserve(n);
        var borrow = 0;
        for (i in 0...n) {
            var bi = (i < b.n ? b.limb[i] : 0) + borrow;
            if (limb[i] >= bi) {
                r.limb[i] = limb[i] - bi;
                borrow = 0;
            } else {
                r.limb[i] = limb[i] + BASE - bi;
                borrow = 1;
            }
        }
        r.n = n;
        r.neg = false;
        r.trim();
    }

    public function add(r:Big, b:Big):Void {
        var an = neg;
        var bn = b.neg;
        if (an == bn) {
            addMag(r, b);
            r.neg = an;
        } else if (cmpMag(b) >= 0) {
            subMag(r, b);
            r.neg = an;
        } else {
            b.subMag(r, this);
            r.neg = bn;
        }
        r.trim();
    }

    public function sub(r:Big, b:Big):Void {       // r = this - b
        var an = neg;
        var bn = b.neg;
        if (an != bn) {
            addMag(r, b);
            r.neg = an;
        } else if (cmpMag(b) >= 0) {
            subMag(r, b);
            r.neg = an;
        } else {
            b.subMag(r, this);
            r.neg = !an;
        }
        r.trim();
    }

    public function mulSmall(r:Big, m:Int):Void {
        if (m == 0 || n == 0) {
            r.n = 0;
            r.neg = false;
            return;
        }
        r.reserve(n + 2);
        var carry = haxe.Int64.ofInt(0);
        for (i in 0...n) {
            var p = haxe.Int64.ofInt(limb[i]) * m + carry;
            r.limb[i] = haxe.Int64.toInt(p % BASE64);
            carry = p / BASE64;
        }
        var count = n;
        while (carry > 0) {
            r.reserve(count + 1);
            r.limb[count++] = haxe.Int64.toInt(carry % BASE64);
            carry = carry / BASE64;
        }
        r.n = count;
        r.neg = neg;
        r.trim();
    }

    // floor(a / b) for a >= 0 and b > 0. The spigot only ever asks for a quotient of one
    // decimal digit, so counting how many times b fits into a is enough.
    public static function quot(a:Big, b:Big, work:Big):Int {
        var q = 0;
        if (a.neg || b.neg || b.n == 0) {
            return 0;
        }
        work.copyFrom(b);
        while (a.cmp(work) >= 0) {
            q++;
            work.addMag(work, b);
        }
        return q;
    }
}

class T10_pi {
    static function main() {
        // timing: haxe.Timer.stamp() is QueryPerformanceCounter on cpp (sub-microsecond); Sys.time() there is wall-clock ms.
        var t0 = haxe.Timer.stamp();
        var q = new Big();
        var r = new Big();
        var t = new Big();
        var u = new Big();
        var v = new Big();
        var w = new Big();

        q.set(haxe.Int64.ofInt(1));
        r.set(haxe.Int64.ofInt(0));
        t.set(haxe.Int64.ofInt(1));

        var k = 1;
        var l = 3;
        var n = 3;
        var sum = 0;

        var produced = 0;
        while (produced < 1000) {
            q.mulSmall(u, 4);
            u.add(u, r);                     // u = 4q + r
            t.mulSmall(v, n + 1);            // v = (n + 1)t

            if (u.cmp(v) < 0) {
                // the digit n is settled
                sum += n;
                produced++;

                q.mulSmall(u, 3);
                u.add(u, r);                 // u = 3q + r
                u.mulSmall(u, 10);           // u = 10(3q + r)
                var next = Big.quot(u, t, w) - 10 * n;

                t.mulSmall(v, n);            // v = n t
                r.sub(v, v);                 // v = r - n t
                v.mulSmall(r, 10);           // r = 10(r - n t)
                q.mulSmall(q, 10);           // q = 10q, t is unchanged

                n = next;
            } else {
                // not settled yet: widen the state by one more term
                q.mulSmall(u, 7 * k + 2);
                r.mulSmall(v, l);
                u.add(u, v);                 // u = q(7k + 2) + r l
                t.mulSmall(v, l);            // v = t l
                var next = Big.quot(u, v, w);

                q.mulSmall(u, 2);
                u.add(u, r);
                u.mulSmall(u, l);            // u = (2q + r) l
                r.copyFrom(u);
                q.mulSmall(q, k);
                t.mulSmall(t, l);

                k++;
                l += 2;
                n = next;
            }
        }

        var t1 = haxe.Timer.stamp();
        Sys.stderr().writeString("TIME_MS=" + ((t1 - t0) * 1000.0) + "\n");
        Sys.println(sum);
    }
}
