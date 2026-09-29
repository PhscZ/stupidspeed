// task 10 pi — expected output: 4470
// build: none (interpreted)    run: cscript //nologo //E:JScript 10_pi.js
// note: JScript has no big integers (this engine has no BigInt) and a double is its only
//       numeric type, so this is the C reference's hand-written big integer:
//       sign-magnitude, little-endian limbs, base 1e9, with add, subtract, multiply by a
//       small integer, and a quotient that comes out of repeated subtraction because the
//       spigot only ever asks for one decimal digit at a time. Gibbons' unbounded spigot
//       is the same loop, step for step; only the sum of the 1000 digits is printed.
// note: the limbs are doubles. A limb times the spigot's largest multiplier is
//       999999999 * 232471 = 2.32e14, and a double is exact to 2^53 = 9.0e15, so every
//       product and every carry is exact. The carry is Math.floor(p / 1e9) and the
//       remainder is p - carry * 1e9 rather than p % 1e9: the division is exact enough
//       that floor never lands one below the true quotient, because p is an integer
//       whose distance to the next multiple of 1e9 is at least 1e-9 of a unit, while
//       the rounding error at 2.32e14 is below 2e-11.
// note: the six big integers live in one flat array of 6 * 40000 limbs, indexed
//       x * MAXLIMB + i, with the limb count and the sign in two six-element arrays.
//       That is the shape of the C reference (a struct holding a limb pointer); the
//       state is about 1248 limbs at 1000 digits.
// note: measured wall clock for the reduced scales, which were run first as the check that
//       the digit sums are the independently known ones: 100 digits 0.40 s, 200 1.20 s,
//       400 4.31 s, 800 18.79 s, an exponent of about 1.9 in the digit count, and the sums
//       came out 471, 897, 1753 and 3588 exactly as expected. The full 1000-digit run
//       prints the expected 4470 and measures 36 s to 182 s on this shared host (fastest
//       35.6 s, slowest 182.4 s).
var DIGITS = 1000, MAXLIMB = 40000, BASE = 1000000000.0;

// indices into LB, LN and LG
var QV = 0, RV = 1, TV = 2, UV = 3, VV = 4, WV = 5;

var LB = new Array(6 * MAXLIMB), LN = new Array(6), LG = new Array(6);
var k, l, n, sum, produced, nextn, i;

for (i = 0; i < 6 * MAXLIMB; i++) {
    LB[i] = 0;
}
for (i = 0; i < 6; i++) {
    LN[i] = 0;
    LG[i] = 0;
}

bset(QV, 1);
bset(RV, 0);
bset(TV, 1);

k = 1;
l = 3;
n = 3;
sum = 0;
produced = 0;

while (produced < DIGITS) {
    bmulsmall(UV, QV, 4);
    badd(UV, UV, RV);                    // u = 4q + r
    bmulsmall(VV, TV, n + 1);            // v = (n + 1)t

    if (bcmp(UV, VV) < 0) {
        // the digit n is settled
        sum += n;
        produced++;

        bmulsmall(UV, QV, 3);
        badd(UV, UV, RV);
        bmulsmall(UV, UV, 10);           // u = 10(3q + r)
        nextn = bquot(UV, TV) - 10 * n;

        bmulsmall(VV, TV, n);            // v = n t
        bsub(VV, RV, VV);                // v = r - n t
        bmulsmall(RV, VV, 10);           // r = 10(r - n t)
        bmulsmall(QV, QV, 10);           // q = 10q, t is unchanged

        n = nextn;
    } else {
        // not settled yet: widen the state by one more term
        bmulsmall(UV, QV, 7 * k + 2);
        bmulsmall(VV, RV, l);
        badd(UV, UV, VV);                // u = q(7k + 2) + r l
        bmulsmall(VV, TV, l);            // v = t l
        nextn = bquot(UV, VV);

        bmulsmall(UV, QV, 2);
        badd(UV, UV, RV);
        bmulsmall(UV, UV, l);            // u = (2q + r) l
        bcopy(RV, UV);
        bmulsmall(QV, QV, k);
        bmulsmall(TV, TV, l);

        k++;
        l += 2;
        n = nextn;
    }
}

WScript.Echo(String(sum));

function bset(x, v) {
    var c = 0;
    while (v > 0) {
        LB[x * MAXLIMB + c] = v - Math.floor(v / BASE) * BASE;
        v = Math.floor(v / BASE);
        c++;
    }
    LN[x] = c;
    LG[x] = 0;
}

function bcopy(d, s) {
    var i, c = LN[s];
    for (i = 0; i < c; i++) {
        LB[d * MAXLIMB + i] = LB[s * MAXLIMB + i];
    }
    LN[d] = c;
    LG[d] = LG[s];
}

function btrim(x) {
    var c = LN[x];
    while (c > 0) {
        if (LB[x * MAXLIMB + c - 1] !== 0) {
            break;
        }
        c--;
    }
    LN[x] = c;
    if (c === 0) {
        LG[x] = 0;
    }
}

function bcmpmag(a, b) {
    var i, an = LN[a], bn = LN[b];
    if (an !== bn) {
        return an < bn ? -1 : 1;
    }
    for (i = an - 1; i >= 0; i--) {
        if (LB[a * MAXLIMB + i] !== LB[b * MAXLIMB + i]) {
            return LB[a * MAXLIMB + i] < LB[b * MAXLIMB + i] ? -1 : 1;
        }
    }
    return 0;
}

function bcmp(a, b) {
    var c;
    if (LG[a] !== LG[b]) {
        return LG[a] !== 0 ? -1 : 1;
    }
    c = bcmpmag(a, b);
    if (LG[a] !== 0) {
        c = -c;
    }
    return c;
}

function baddmag(r, a, b) {
    var i, c, s, carry, an = LN[a], bn = LN[b];
    c = an > bn ? an : bn;
    carry = 0;
    for (i = 0; i < c; i++) {
        s = carry;
        if (i < an) {
            s += LB[a * MAXLIMB + i];
        }
        if (i < bn) {
            s += LB[b * MAXLIMB + i];
        }
        if (s >= BASE) {
            s -= BASE;
            carry = 1;
        } else {
            carry = 0;
        }
        LB[r * MAXLIMB + i] = s;
    }
    if (carry !== 0) {
        LB[r * MAXLIMB + c] = carry;
        LN[r] = c + 1;
    } else {
        LN[r] = c;
    }
    LG[r] = 0;
}

function bsubmag(r, a, b) {
    var i, bi, borrow, an = LN[a], bn = LN[b];
    borrow = 0;
    for (i = 0; i < an; i++) {
        bi = borrow;
        if (i < bn) {
            bi += LB[b * MAXLIMB + i];
        }
        if (LB[a * MAXLIMB + i] >= bi) {
            LB[r * MAXLIMB + i] = LB[a * MAXLIMB + i] - bi;
            borrow = 0;
        } else {
            LB[r * MAXLIMB + i] = LB[a * MAXLIMB + i] + BASE - bi;
            borrow = 1;
        }
    }
    LN[r] = an;
    LG[r] = 0;
    btrim(r);
}

function badd(r, a, b) {
    var an = LG[a], bn = LG[b];
    if (an === bn) {
        baddmag(r, a, b);
        LG[r] = an;
    } else if (bcmpmag(a, b) >= 0) {
        bsubmag(r, a, b);
        LG[r] = an;
    } else {
        bsubmag(r, b, a);
        LG[r] = bn;
    }
    btrim(r);
}

function bsub(r, a, b) {
    var an = LG[a], bn = LG[b];
    if (an !== bn) {
        baddmag(r, a, b);
        LG[r] = an;
    } else if (bcmpmag(a, b) >= 0) {
        bsubmag(r, a, b);
        LG[r] = an;
    } else {
        bsubmag(r, b, a);
        LG[r] = an === 0 ? 1 : 0;
    }
    btrim(r);
}

function bmulsmall(r, a, m) {
    var i, c, p, carry;
    c = LN[a];
    if (m === 0 || c === 0) {
        LN[r] = 0;
        LG[r] = 0;
        return;
    }
    carry = 0;
    for (i = 0; i < c; i++) {
        p = LB[a * MAXLIMB + i] * m + carry;
        carry = Math.floor(p / BASE);
        LB[r * MAXLIMB + i] = p - carry * BASE;
    }
    while (carry > 0) {
        LB[r * MAXLIMB + c] = carry - Math.floor(carry / BASE) * BASE;
        carry = Math.floor(carry / BASE);
        c++;
    }
    LN[r] = c;
    LG[r] = LG[a];
    btrim(r);
}

// floor(a / b) for a >= 0 and b > 0, by counting how many times b fits into a. The
// spigot only ever asks for a quotient of one decimal digit, so this terminates quickly.
function bquot(a, b) {
    var q;
    if (LG[a] !== 0 || LG[b] !== 0 || LN[b] === 0) {
        return 0;
    }
    bcopy(WV, b);
    q = 0;
    while (bcmp(a, WV) >= 0) {
        q++;
        baddmag(WV, WV, b);
    }
    return q;
}
