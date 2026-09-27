// task 10 pi — expected output: 44889
// build: amxmlc -swf-version=51 -output prog.swf _10_pi.as  then  adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: AS3 has no arbitrary-precision integers, so this is the same hand-written big
//       integer the C row uses, ported operation for operation: sign-magnitude,
//       little-endian base-1e9 limbs, with add, subtract, multiply by a small integer,
//       and a quotient that is always one decimal digit and so comes out of repeated
//       subtraction. Same Gibbons unbounded spigot, same update order, same six
//       variables.
// note: limbs are AS3 Number (IEEE double), not int. The largest intermediate is a limb
//       times a small multiplier, at most 999999999 * 232472 ~= 2.3e14, far inside the
//       2^53 range where a double is exact, so every product and carry is exact. int
//       would wrap at 2^31 and cannot be used.
// note: the six limb vectors are allocated once at full size and every operation writes
//       into one of them in place, so the 20000-odd spigot iterations allocate nothing
//       at all. An earlier version returned a fresh object per operation, which churned
//       hundreds of megabytes of 16000-limb vectors and died with "out of memory".
// note: the spigot's state reaches about 145728 digits at 10000 digits, which is 16192
//       limbs, so 20000 limbs per variable has a little margin. Only the sum of the
//       digits is printed.

package
{
    import flash.display.Sprite;
    import flash.system.System;
    import flash.desktop.NativeApplication;

    public class _10_pi extends Sprite
    {
        public function _10_pi()
        {
            var q:Big = new Big(), r:Big = new Big(), t:Big = new Big();
            var u:Big = new Big(), v:Big = new Big(), w:Big = new Big();

            Big.set(q, 1);
            Big.set(r, 0);
            Big.set(t, 1);

            var k:Number = 1, l:Number = 3, n:Number = 3;
            var sum:Number = 0;
            var produced:int = 0;

            while (produced < 10000)
            {
                Big.mulSmall(u, q, 4);
                Big.add(u, u, r);                 // u = 4q + r
                Big.mulSmall(v, t, n + 1);        // v = (n + 1)t

                if (Big.cmp(u, v) < 0)
                {
                    // the digit n is settled
                    sum = sum + n;
                    produced = produced + 1;

                    Big.mulSmall(u, q, 3);
                    Big.add(u, u, r);
                    Big.mulSmall(u, u, 10);              // u = 10(3q + r)
                    var next:Number = Big.quot(u, t, w) - 10 * n;

                    Big.mulSmall(v, t, n);               // v = n t
                    Big.sub(v, r, v);                    // v = r - n t
                    Big.mulSmall(r, v, 10);              // r = 10(r - n t)
                    Big.mulSmall(q, q, 10);              // q = 10q, t is unchanged

                    n = next;
                }
                else
                {
                    // not settled yet: widen the state by one more term
                    Big.mulSmall(u, q, 7 * k + 2);
                    Big.mulSmall(v, r, l);
                    Big.add(u, u, v);                    // u = q(7k + 2) + r l
                    Big.mulSmall(v, t, l);               // v = t l
                    var next2:Number = Big.quot(u, v, w);

                    Big.mulSmall(u, q, 2);
                    Big.add(u, u, r);
                    Big.mulSmall(u, u, l);               // u = (2q + r) l
                    Big.copy(r, u);
                    Big.mulSmall(q, q, k);
                    Big.mulSmall(t, t, l);

                    k = k + 1;
                    l = l + 2;
                    n = next2;
                }
            }

            System.output(sum + "\n");
            NativeApplication.nativeApplication.exit(0);
        }
    }
}

// Little-endian base-1e9 sign-magnitude big integer. Six of these are allocated once
// and every operation writes its result into one of them, so nothing is allocated after
// start-up. Only the operations the spigot needs are implemented.
internal class Big
{
    public static const BASE:Number = 1000000000;
    public static const LIMBS:int = 20000;

    public var limb:Vector.<Number>;
    public var n:int;
    public var neg:Boolean;

    public function Big():void
    {
        limb = new Vector.<Number>(LIMBS);
        n = 0;
        neg = false;
    }

    public static function trim(x:Big):void
    {
        while (x.n > 0 && x.limb[x.n - 1] == 0) { x.n = x.n - 1; }
        if (x.n == 0) { x.neg = false; }
    }

    public static function set(x:Big, value:Number):void
    {
        x.n = 0;
        x.neg = false;
        while (value > 0)
        {
            x.limb[x.n] = value % BASE;
            x.n = x.n + 1;
            value = Math.floor(value / BASE);
        }
    }

    public static function copy(dst:Big, src:Big):void
    {
        if (dst == src) { return; }
        for (var i:int = 0; i < src.n; i++) { dst.limb[i] = src.limb[i]; }
        dst.n = src.n;
        dst.neg = src.neg;
    }

    public static function cmpMag(a:Big, b:Big):int
    {
        if (a.n != b.n) { return a.n < b.n ? -1 : 1; }
        for (var i:int = a.n - 1; i >= 0; i--)
        {
            if (a.limb[i] != b.limb[i]) { return a.limb[i] < b.limb[i] ? -1 : 1; }
        }
        return 0;
    }

    public static function cmp(a:Big, b:Big):int
    {
        if (a.neg != b.neg) { return a.neg ? -1 : 1; }
        var c:int = cmpMag(a, b);
        return a.neg ? -c : c;
    }

    // r = a + b, magnitudes only; r may alias a or b
    public static function addMag(r:Big, a:Big, b:Big):void
    {
        var len:int = a.n > b.n ? a.n : b.n;
        var carry:Number = 0;
        for (var i:int = 0; i < len; i++)
        {
            var s:Number = carry;
            if (i < a.n) { s = s + a.limb[i]; }
            if (i < b.n) { s = s + b.limb[i]; }
            if (s >= BASE) { s = s - BASE; carry = 1; } else { carry = 0; }
            r.limb[i] = s;
        }
        if (carry != 0) { r.limb[len] = carry; len = len + 1; }
        r.n = len;
        trim(r);
    }

    // r = a - b, requires |a| >= |b|; r may alias a or b
    public static function subMag(r:Big, a:Big, b:Big):void
    {
        var an:int = a.n;
        var bn:int = b.n;
        var borrow:Number = 0;
        for (var i:int = 0; i < an; i++)
        {
            var bi:Number = borrow;
            if (i < bn) { bi = bi + b.limb[i]; }
            if (a.limb[i] >= bi) { r.limb[i] = a.limb[i] - bi; borrow = 0; }
            else { r.limb[i] = a.limb[i] + BASE - bi; borrow = 1; }
        }
        r.n = an;
        trim(r);
    }

    public static function add(r:Big, a:Big, b:Big):void
    {
        if (a.neg == b.neg)
        {
            addMag(r, a, b);
            r.neg = a.neg && r.n > 0;
        }
        else if (cmpMag(a, b) >= 0)
        {
            subMag(r, a, b);
            r.neg = a.neg && r.n > 0;
        }
        else
        {
            subMag(r, b, a);
            r.neg = b.neg && r.n > 0;
        }
    }

    public static function sub(r:Big, a:Big, b:Big):void
    {
        if (a.neg != b.neg)
        {
            addMag(r, a, b);
            r.neg = a.neg && r.n > 0;
        }
        else if (cmpMag(a, b) >= 0)
        {
            subMag(r, a, b);
            r.neg = a.neg && r.n > 0;
        }
        else
        {
            subMag(r, b, a);
            r.neg = !a.neg && r.n > 0;
        }
    }

    public static function mulSmall(r:Big, a:Big, m:Number):void
    {
        if (m == 0 || a.n == 0)
        {
            r.n = 0;
            r.neg = false;
            return;
        }
        var carry:Number = 0;
        for (var i:int = 0; i < a.n; i++)
        {
            var p:Number = a.limb[i] * m + carry;
            r.limb[i] = p % BASE;
            carry = Math.floor(p / BASE);
        }
        var len:int = a.n;
        while (carry > 0)
        {
            r.limb[len] = carry % BASE;
            len = len + 1;
            carry = Math.floor(carry / BASE);
        }
        r.n = len;
        r.neg = a.neg;
        trim(r);
    }

    // floor(a / b) for a >= 0 and b > 0. The spigot only ever asks for a quotient of one
    // decimal digit, so counting how many times b fits into a is enough -- the same
    // repeated subtraction the C row does. work is scratch, and must not alias a or b.
    public static function quot(a:Big, b:Big, work:Big):Number
    {
        var qv:Number = 0;
        if (a.neg || b.neg || b.n == 0) { return 0; }
        copy(work, b);
        while (cmp(a, work) >= 0)
        {
            qv = qv + 1;
            addMag(work, work, b);
        }
        return qv;
    }
}
