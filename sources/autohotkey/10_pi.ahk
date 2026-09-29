; task 10 pi — expected output: 4470
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 10_pi.ahk
; note: AutoHotkey has no big-integer type — its integers are 64-bit signed — so this
;       is the C reference's hand-written big integer: sign-magnitude, little-endian
;       limbs, base 1e9, with add, subtract, multiply by a small integer, and a
;       quotient that comes out of repeated subtraction because the spigot only ever
;       asks for one decimal digit at a time. Gibbons' unbounded spigot is the same
;       loop, step for step; only the sum of the 1000 digits is printed.
; note: the limbs are ordinary 64-bit integers, which is the whole reason this row is
;       faster than the VBScript one here: a limb times the spigot's multiplier is at
;       most 999999999 * 232471, about 2.3e14, and the carry is an exact "//" and the
;       remainder an exact Mod, with no floating point anywhere. "//" truncates towards
;       zero, which is the floor the C row's "/" on uint64 gives for these non-negative
;       values. 1e9 fits in a 32-bit limb but the products do not, so 64 bits is the
;       working width, the same as the C reference.
; note: the six big integers are six AutoHotkey Arrays of 40002 elements. A big number
;       is stored as [limb count, sign, limb 0, limb 1, ...], so one array index gets
;       both the metadata and the limb; AutoHotkey has no two-dimensional array and an
;       array of arrays would cost an extra object indirection per limb operation.
;       About 1248 limbs are live at 1000 digits, so the 40000-limb sizing is ample.
; note: the digit sum is a small integer, so it is printed by the plain conversion.
; note: the 1000-digit run takes about 73 s on this machine (a pass on the same shared host
;       measured 288 s). The arithmetic was checked at a reduced scale first, against digit
;       sums recomputed independently in Python with arbitrary-precision integers: 100 -> 471,
;       200 -> 897, 400 -> 1753, 1000 -> 4470. This program printed 471 at 100 digits (0.6 s)
;       and 4470 at the full 1000.
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

DIGITS := 1000
MAXLIMB := 40000

q := BNew()
r := BNew()
t := BNew()
u := BNew()
v := BNew()
w := BNew()

BSet(q, 1)
BSet(r, 0)
BSet(t, 1)

k := 1
l := 3
n := 3
sum := 0
produced := 0

while (produced < DIGITS) {
    BMulSmall(u, q, 4)
    BAdd(u, u, r)                       ; u = 4q + r
    BMulSmall(v, t, n + 1)              ; v = (n + 1)t

    if (BCmp(u, v) < 0) {
        ; the digit n is settled
        sum += n
        produced += 1

        BMulSmall(u, q, 3)
        BAdd(u, u, r)
        BMulSmall(u, u, 10)             ; u = 10(3q + r)
        nextn := BQuot(u, t, w) - 10 * n

        BMulSmall(v, t, n)              ; v = n t
        BSub(v, r, v)                   ; v = r - n t
        BMulSmall(r, v, 10)             ; r = 10(r - n t)
        BMulSmall(q, q, 10)             ; q = 10q, t is unchanged

        n := nextn
    } else {
        ; not settled yet: widen the state by one more term
        BMulSmall(u, q, 7 * k + 2)
        BMulSmall(v, r, l)
        BAdd(u, u, v)                   ; u = q(7k + 2) + r l
        BMulSmall(v, t, l)              ; v = t l
        nextn := BQuot(u, v, w)

        BMulSmall(u, q, 2)
        BAdd(u, u, r)
        BMulSmall(u, u, l)              ; u = (2q + r) l
        BCopy(r, u)
        BMulSmall(q, q, k)
        BMulSmall(t, t, l)

        k += 1
        l += 2
        n := nextn
    }
}

FileAppend(sum "`n", "*")

; A fresh big number: [limb count, sign, limb 0, limb 1, ...], pre-sized so the limbs
; are not appended one element at a time. Sign 1 means negative.
BNew() {
    global MAXLIMB
    a := []
    a.Length := MAXLIMB + 2
    a[1] := 0
    a[2] := 0
    return a
}

BSet(x, v) {
    static BASE := 1000000000
    c := 0
    while (v > 0) {
        x[c + 3] := Mod(v, BASE)
        v := v // BASE
        c += 1
    }
    x[1] := c
    x[2] := 0
}

BCopy(d, s) {
    c := s[1]
    Loop c
        d[A_Index + 2] := s[A_Index + 2]
    d[1] := c
    d[2] := s[2]
}

BTrim(x) {
    c := x[1]
    while (c > 0) {
        if (x[c + 2] != 0)
            break
        c -= 1
    }
    x[1] := c
    if (c = 0)
        x[2] := 0
}

BCmpMag(a, b) {
    an := a[1]
    bn := b[1]
    if (an != bn)
        return an < bn ? -1 : 1
    i := an
    while (i > 0) {
        if (a[i + 2] != b[i + 2])
            return a[i + 2] < b[i + 2] ? -1 : 1
        i -= 1
    }
    return 0
}

BCmp(a, b) {
    if (a[2] != b[2])
        return a[2] ? -1 : 1
    c := BCmpMag(a, b)
    return a[2] ? -c : c
}

BAddMag(r, a, b) {
    static BASE := 1000000000
    an := a[1]
    bn := b[1]
    n := an > bn ? an : bn
    carry := 0
    i := 0
    while (i < n) {
        s := carry
        if (i < an)
            s += a[i + 3]
        if (i < bn)
            s += b[i + 3]
        if (s >= BASE) {
            s -= BASE
            carry := 1
        } else
            carry := 0
        r[i + 3] := s
        i += 1
    }
    if (carry) {
        r[n + 3] := carry
        r[1] := n + 1
    } else
        r[1] := n
    r[2] := 0
}

BSubMag(r, a, b) {                      ; requires a >= b >= 0
    static BASE := 1000000000
    an := a[1]
    bn := b[1]
    borrow := 0
    i := 0
    while (i < an) {
        bi := borrow
        if (i < bn)
            bi += b[i + 3]
        if (a[i + 3] >= bi) {
            r[i + 3] := a[i + 3] - bi
            borrow := 0
        } else {
            r[i + 3] := a[i + 3] + BASE - bi
            borrow := 1
        }
        i += 1
    }
    r[1] := an
    r[2] := 0
    BTrim(r)
}

BAdd(r, a, b) {
    an := a[2]
    bn := b[2]
    if (an = bn) {
        BAddMag(r, a, b)
        r[2] := an
    } else if (BCmpMag(a, b) >= 0) {
        BSubMag(r, a, b)
        r[2] := an
    } else {
        BSubMag(r, b, a)
        r[2] := bn
    }
    BTrim(r)
}

BSub(r, a, b) {                         ; r = a - b
    an := a[2]
    bn := b[2]
    if (an != bn) {
        BAddMag(r, a, b)
        r[2] := an
    } else if (BCmpMag(a, b) >= 0) {
        BSubMag(r, a, b)
        r[2] := an
    } else {
        BSubMag(r, b, a)
        r[2] := an ? 0 : 1
    }
    BTrim(r)
}

BMulSmall(r, a, m) {
    static BASE := 1000000000
    c := a[1]
    if (m = 0 || c = 0) {
        r[1] := 0
        r[2] := 0
        return
    }
    carry := 0
    i := 0
    while (i < c) {
        p := a[i + 3] * m + carry
        carry := p // BASE
        r[i + 3] := p - carry * BASE
        i += 1
    }
    while (carry > 0) {
        r[c + 3] := Mod(carry, BASE)
        carry := carry // BASE
        c += 1
    }
    r[1] := c
    r[2] := a[2]
    BTrim(r)
}

; floor(a / b) for a >= 0 and b > 0, by counting how many times b fits into a. The
; spigot only ever asks for a quotient of one decimal digit, so this terminates quickly.
BQuot(a, b, work) {
    q := 0
    if (a[2] != 0 || b[2] != 0 || b[1] = 0)
        return 0
    BCopy(work, b)
    while (BCmp(a, work) >= 0) {
        q += 1
        BAddMag(work, work, b)
    }
    return q
}
