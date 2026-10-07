-- task 10 pi — expected output: 4470
-- build: none (interpreted)
-- run: EUDIR="C:\stupidspeed\tools\euphoria" C:\stupidspeed\tools\euphoria\bin\eui.exe 10_pi.ex
-- timing: QueryPerformanceCounter via kernel32 FFI; TIME_MS goes to time.txt (Euphoria
--         cannot reach stderr in this build).
-- note: Euphoria's standard library has no arbitrary-precision integers, so the Gibbons
--       unbounded spigot runs on hand-rolled bignums: base 1e9 limbs, little endian, with
--       a sign field. This is a port of sources/lua/10_pi.lua (same algorithm, same loop).
--       A bignum is {n, s, limb1, limb2, ...}: n = limb count (0 for zero), s = sign (+1
--       or -1), limbs at indices 3..n+2. Euphoria sequences are value types, so each
--       operation returns a fresh bignum instead of mutating in place; every intermediate
--       stays well below 2^53 (limb < 1e9, multipliers are small).
--       Only the digit sum is printed.

include std/dll.e
include std/machine.e

atom k32, freq, buf, t0, t1, r, ms
integer pF, pC
k32 = open_dll("kernel32.dll")
pF = define_c_func(k32, "QueryPerformanceFrequency", {C_POINTER}, C_LONG)
pC = define_c_func(k32, "QueryPerformanceCounter", {C_POINTER}, C_LONG)
buf = allocate(8)
r = c_func(pF, {buf})
freq = peek8u(buf)
r = c_func(pC, {buf})
t0 = peek8u(buf)

constant BASE = 1000000000
constant BZERO = {0, 1}

function bcmpmag(sequence a, sequence b)
    integer an, bn, x, y
    an = a[1]
    bn = b[1]
    if an != bn then
        if an < bn then return -1 else return 1 end if
    end if
    for i = an to 1 by -1 do
        x = a[i + 2]
        y = b[i + 2]
        if x != y then
            if x < y then return -1 else return 1 end if
        end if
    end for
    return 0
end function

-- a * m, m a small non-negative integer
function bmul(sequence a, atom m)
    integer n, carry, q
    n = a[1]
    if m = 0 or n = 0 then
        return BZERO
    end if
    sequence d
    d = repeat(0, n + 2)
    d[1] = n
    d[2] = a[2]
    carry = 0
    for i = 1 to n do
        atom v
        v = a[i + 2] * m + carry
        q = floor(v / BASE)
        d[i + 2] = v - q * BASE
        carry = q
    end for
    while carry > 0 do
        q = floor(carry / BASE)
        d = append(d, carry - q * BASE)
        carry = q
    end while
    d[1] = length(d) - 2
    return d
end function

-- ca*a + cb*b + cc*c with signed small coefficients
function blin(sequence a, integer ca, sequence b, integer cb, sequence c, integer cc)
    integer an, bn, cn, n, ea, eb, ec, carry, q
    an = a[1]
    bn = b[1]
    cn = c[1]
    ea = 0
    if an != 0 then ea = ca * a[2] end if
    eb = 0
    if bn != 0 then eb = cb * b[2] end if
    ec = 0
    if cn != 0 then ec = cc * c[2] end if
    n = an
    if bn > n then n = bn end if
    if cn > n then n = cn end if
    sequence d
    d = repeat(0, n + 2)
    carry = 0
    for i = 1 to n do
        atom acc
        acc = carry
        if i <= an then acc = acc + a[i + 2] * ea end if
        if i <= bn then acc = acc + b[i + 2] * eb end if
        if i <= cn then acc = acc + c[i + 2] * ec end if
        q = floor(acc / BASE)
        d[i + 2] = acc - q * BASE
        carry = q
    end for
    if carry = 0 then
        while n > 0 and d[n + 2] = 0 do
            n = n - 1
        end while
        d = d[1 .. n + 2]
        d[1] = n
        d[2] = 1
    elsif carry > 0 then
        while carry > 0 do
            q = floor(carry / BASE)
            d = append(d, carry - q * BASE)
            carry = q
        end while
        d[1] = length(d) - 2
        d[2] = 1
    else
        integer t, c2, v
        t = -carry
        c2 = 1
        for i = 1 to n do
            v = BASE - 1 - d[i + 2] + c2
            if v >= BASE then
                v = v - BASE
                c2 = 1
            else
                c2 = 0
            end if
            d[i + 2] = v
        end for
        d = append(d, t - 1 + c2)
        n = n + 1
        while n > 0 and d[n + 2] = 0 do
            n = n - 1
        end while
        d = d[1 .. n + 2]
        d[1] = n
        d[2] = -1
    end if
    return d
end function

function bcmp(sequence a, sequence b)
    integer c
    if a[1] = 0 then
        if b[1] = 0 then return 0 end if
        return -b[2]
    end if
    if b[1] = 0 then return a[2] end if
    if a[2] != b[2] then return a[2] end if
    c = bcmpmag(a, b)
    if a[2] > 0 then return c end if
    return -c
end function

-- floor(|u| / |v|), |v| > 0; returns {quotient, exact}
function bqmag(sequence u, sequence v)
    integer un, vn, shift
    un = u[1]
    vn = v[1]
    if un < vn then
        return {0, 0}
    end if
    shift = un - vn
    atom aa, bb, q
    aa = u[un + 2] * BASE
    if un > 1 then aa = aa + u[un + 1] end if
    bb = v[vn + 2] * BASE
    if vn > 1 then bb = bb + v[vn + 1] end if
    if shift = 0 then
        q = floor(aa / bb)
    else
        atom p
        p = BASE
        for k = 2 to shift do
            p = p * BASE
        end for
        q = floor((aa / bb) * p)
    end if
    sequence cur
    cur = bmul(v, q)
    while bcmpmag(cur, u) > 0 do
        q = q - 1
        cur = bmul(v, q)
    end while
    sequence s2
    while 1 do
        s2 = bmul(v, q + 1)
        if bcmpmag(s2, u) <= 0 then
            q = q + 1
            cur = s2
        else
            exit
        end if
    end while
    integer exact
    if bcmpmag(cur, u) = 0 then
        exact = 1
    else
        exact = 0
    end if
    return {q, exact}
end function

-- floor(num / den), den > 0
function bfloorq(sequence num, sequence den)
    if num[1] = 0 then
        return 0
    end if
    sequence qr
    qr = bqmag(num, den)
    integer q, exact
    q = qr[1]
    exact = qr[2]
    if num[2] > 0 or exact = 1 then
        return q
    end if
    return -q - 1
end function

sequence BQ, BR, BT, A, B, C, D, tmp
integer k, n, l, emitted, digitsum, oldn, nnew

BQ = {1, 1, 1}
BR = {0, 1}
BT = {1, 1, 1}
k = 1
n = 3
l = 3
emitted = 0
digitsum = 0

while emitted < 1000 do
    A = blin(BQ, 4, BR, 1, BT, -1)
    B = bmul(BT, n)
    if bcmp(A, B) < 0 then
        oldn = n
        digitsum = digitsum + oldn
        emitted = emitted + 1
        C = blin(BQ, 30, BR, 10, BZERO, 0)
        nnew = bfloorq(C, BT) - 10 * oldn
        BQ = bmul(BQ, 10)
        BR = blin(BR, 10, BT, -10 * oldn, BZERO, 0)
        n = nnew
    else
        C = blin(BQ, 7 * k + 2, BR, l, BZERO, 0)
        D = bmul(BT, l)
        n = bfloorq(C, D)
        B = blin(BQ, 2, BR, 1, BZERO, 0)
        B = bmul(B, l)
        BQ = bmul(BQ, k)
        tmp = BR
        BR = B
        B = tmp
        tmp = BT
        BT = D
        D = tmp
        k = k + 1
        l = l + 2
    end if
end while

r = c_func(pC, {buf})
t1 = peek8u(buf)
ms = (t1 - t0) * 1000.0 / freq
printf(1, "%d\n", {digitsum})
integer fh
fh = open("time.txt", "w")
printf(fh, "TIME_MS=%.3f\n", {ms})
close(fh)
