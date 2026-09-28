// task 10 pi — expected output: 4470
// build: valac -X -O2 -o prog 10_pi.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: the binary calls GLib, so it needs the UCRT64 runtime DLLs on PATH when it runs —
//       C:\stupidspeed\tools\msys64\msys64\ucrt64\bin holds libglib-2.0-0.dll (and
//       libgobject-2.0-0.dll for task 10). The Objective-C row needs the GNUstep DLLs from
//       the same directory, so this is the same shape.
// note: GLib has no arbitrary-precision integers, so this is the C reference's hand-written
//       big integer: sign-magnitude, little-endian base-1e9 limbs in `uint64`, with add,
//       subtract, multiply by a small int and a quotient that comes out of repeated
//       subtraction because the spigot only ever asks for one decimal digit. Gibbons'
//       unbounded spigot is unchanged; only the sum of the 1000 digits is printed.
// note: the C reference reallocs its limb buffer; Vala owns its arrays, so `reserve` doubles
//       the limb array and copies the limbs across. Same doubling growth, same algorithm.

const uint64 BASE = 1000000000;

class Big {
    public uint64[] limb;   /* little-endian, base 1e9 */
    public int n = 0;       /* limb count, no leading zero limbs */
    public int neg = 0;

    public Big () {
        limb = new uint64[8];
    }

    public void reserve (int need) {
        if (need <= limb.length) {
            return;
        }
        int cap = limb.length;
        while (cap < need) {
            cap *= 2;
        }
        uint64[] grown = new uint64[cap];
        for (int i = 0; i < n; i++) {
            grown[i] = limb[i];
        }
        limb = grown;
    }

    public void trim () {
        while (n > 0 && limb[n - 1] == 0) {
            n--;
        }
        if (n == 0) {
            neg = 0;
        }
    }

    public void set (uint64 v) {
        n = 0;
        neg = 0;
        while (v > 0) {
            reserve (n + 1);
            limb[n] = v % BASE;
            n++;
            v /= BASE;
        }
    }

    public void copy_from (Big src) {
        reserve (src.n);
        for (int i = 0; i < src.n; i++) {
            limb[i] = src.limb[i];
        }
        n = src.n;
        neg = src.neg;
    }

    public static int cmp_mag (Big a, Big b) {
        if (a.n != b.n) {
            return a.n < b.n ? -1 : 1;
        }
        for (int i = a.n; i-- > 0; ) {
            if (a.limb[i] != b.limb[i]) {
                return a.limb[i] < b.limb[i] ? -1 : 1;
            }
        }
        return 0;
    }

    public static int cmp (Big a, Big b) {
        if (a.neg != b.neg) {
            return a.neg != 0 ? -1 : 1;
        }
        int c = cmp_mag (a, b);
        return a.neg != 0 ? -c : c;
    }

    public static void add_mag (Big r, Big a, Big b) {
        int n = a.n > b.n ? a.n : b.n;
        r.reserve (n + 1);
        uint64 carry = 0;
        for (int i = 0; i < n; i++) {
            uint64 s = carry;
            if (i < a.n) {
                s += a.limb[i];
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
        r.limb[n] = carry;
        r.n = n + (carry != 0 ? 1 : 0);
        r.neg = 0;
    }

    public static void sub_mag (Big r, Big a, Big b) {   /* requires a >= b >= 0 */
        r.reserve (a.n);
        uint64 borrow = 0;
        for (int i = 0; i < a.n; i++) {
            uint64 bi = (i < b.n ? b.limb[i] : 0) + borrow;
            if (a.limb[i] >= bi) {
                r.limb[i] = a.limb[i] - bi;
                borrow = 0;
            } else {
                r.limb[i] = a.limb[i] + BASE - bi;
                borrow = 1;
            }
        }
        r.n = a.n;
        r.neg = 0;
        r.trim ();
    }

    public static void add (Big r, Big a, Big b) {
        int an = a.neg;
        int bn = b.neg;
        if (an == bn) {
            add_mag (r, a, b);
            r.neg = an;
        } else if (cmp_mag (a, b) >= 0) {
            sub_mag (r, a, b);
            r.neg = an;
        } else {
            sub_mag (r, b, a);
            r.neg = bn;
        }
        r.trim ();
    }

    public static void sub (Big r, Big a, Big b) {       /* r = a - b */
        int an = a.neg;
        int bn = b.neg;
        if (an != bn) {
            add_mag (r, a, b);
            r.neg = an;
        } else if (cmp_mag (a, b) >= 0) {
            sub_mag (r, a, b);
            r.neg = an;
        } else {
            sub_mag (r, b, a);
            r.neg = (an != 0) ? 0 : 1;
        }
        r.trim ();
    }

    public static void mul_small (Big r, Big a, uint64 m) {
        if (m == 0 || a.n == 0) {
            r.n = 0;
            r.neg = 0;
            return;
        }
        r.reserve (a.n + 2);
        uint64 carry = 0;
        for (int i = 0; i < a.n; i++) {
            uint64 p = a.limb[i] * m + carry;
            r.limb[i] = p % BASE;
            carry = p / BASE;
        }
        int n = a.n;
        while (carry > 0) {
            r.limb[n] = carry % BASE;
            n++;
            carry /= BASE;
        }
        r.n = n;
        r.neg = a.neg;
        r.trim ();
    }

    /* floor(a / b) for a >= 0 and b > 0. The spigot only ever asks for a quotient of
       one decimal digit, so counting how many times b fits into a is enough. */
    public static uint64 quot (Big a, Big b, Big work) {
        uint64 q = 0;
        if (a.neg != 0 || b.neg != 0 || b.n == 0) {
            return 0;
        }
        work.copy_from (b);
        while (cmp (a, work) >= 0) {
            q++;
            add_mag (work, work, b);
        }
        return q;
    }
}

int main () {
    Big q = new Big ();
    Big r = new Big ();
    Big t = new Big ();
    Big u = new Big ();
    Big v = new Big ();
    Big w = new Big ();

    q.set (1);
    r.set (0);
    t.set (1);

    uint64 k = 1;
    uint64 l = 3;
    uint64 n = 3;
    uint64 sum = 0;

    for (int64 produced = 0; produced < 1000; ) {
        Big.mul_small (u, q, 4);
        Big.add (u, u, r);             /* u = 4q + r */
        Big.mul_small (v, t, n + 1);   /* v = (n + 1)t */

        if (Big.cmp (u, v) < 0) {
            /* the digit n is settled */
            sum += n;
            produced++;

            Big.mul_small (u, q, 3);
            Big.add (u, u, r);
            Big.mul_small (u, u, 10);          /* u = 10(3q + r) */
            uint64 next = Big.quot (u, t, w) - 10 * n;

            Big.mul_small (v, t, n);           /* v = n t */
            Big.sub (v, r, v);                 /* v = r - n t */
            Big.mul_small (r, v, 10);          /* r = 10(r - n t) */
            Big.mul_small (q, q, 10);          /* q = 10q, t is unchanged */

            n = next;
        } else {
            /* not settled yet: widen the state by one more term */
            Big.mul_small (u, q, 7 * k + 2);
            Big.mul_small (v, r, l);
            Big.add (u, u, v);                 /* u = q(7k + 2) + r l */
            Big.mul_small (v, t, l);           /* v = t l */
            uint64 next = Big.quot (u, v, w);

            Big.mul_small (u, q, 2);
            Big.add (u, u, r);
            Big.mul_small (u, u, l);           /* u = (2q + r) l */
            r.copy_from (u);
            Big.mul_small (q, q, k);
            Big.mul_small (t, t, l);

            k++;
            l += 2;
            n = next;
        }
    }

    stdout.printf ("%llu\n", sum);
    return 0;
}
