-- task 10 pi — expected output: 44889
-- build: none (interpreted)    run: lua 10_pi.lua (PUC Lua 5.4)    also runs on LuaJIT: luajit 10_pi.lua
-- Lua has no arbitrary-precision integers, so the Gibbons unbounded spigot runs on
-- hand-written bignums: base 1e9 limbs in a table, multiply by a small integer, and
-- divide by a bignum whose quotient is a single digit (found by one estimated multiply
-- and corrected by comparison). Every intermediate stays well below 2^53.
-- The digits themselves are never printed, only their sum.

local BASE = 1000000000

-- A bignum is a table whose limbs live at 1..n, little endian, each in [0, BASE),
-- plus field n (limb count, 0 for zero) and field s (sign, 1 or -1).

local function bcmpmag(a, b)
    local an, bn = a.n, b.n
    if an ~= bn then
        return an < bn and -1 or 1
    end
    for i = an, 1, -1 do
        local x, y = a[i], b[i]
        if x ~= y then
            return x < y and -1 or 1
        end
    end
    return 0
end

local function bcmp(a, b)
    if a.n == 0 then
        if b.n == 0 then
            return 0
        end
        return -b.s
    end
    if b.n == 0 then
        return a.s
    end
    if a.s ~= b.s then
        return a.s
    end
    local c = bcmpmag(a, b)
    if a.s > 0 then
        return c
    end
    return -c
end

-- dst = a * m, m a small non-negative integer; dst may alias a
local function bmul(dst, a, m)
    local n = a.n
    if m == 0 or n == 0 then
        dst.n = 0
        dst.s = 1
        return dst
    end
    local carry = 0
    for i = 1, n do
        local v = a[i] * m + carry
        local q = math.floor(v / BASE)
        dst[i] = v - q * BASE
        carry = q
    end
    while carry > 0 do
        n = n + 1
        local q = math.floor(carry / BASE)
        dst[n] = carry - q * BASE
        carry = q
    end
    dst.n = n
    dst.s = a.s
    return dst
end

-- dst = ca*a + cb*b + cc*c with signed small coefficients; dst may alias an operand
local function blin(dst, a, ca, b, cb, c, cc)
    local an = a.n
    local bn = b and b.n or 0
    local cn = c and c.n or 0
    local ea = an ~= 0 and ca * a.s or 0
    local eb = bn ~= 0 and cb * b.s or 0
    local ec = cn ~= 0 and cc * c.s or 0
    local n = an
    if bn > n then
        n = bn
    end
    if cn > n then
        n = cn
    end
    local carry = 0
    for i = 1, n do
        local acc = carry
        if i <= an then
            acc = acc + a[i] * ea
        end
        if i <= bn then
            acc = acc + b[i] * eb
        end
        if i <= cn then
            acc = acc + c[i] * ec
        end
        local q = math.floor(acc / BASE)
        dst[i] = acc - q * BASE
        carry = q
    end
    if carry == 0 then
        while n > 0 and dst[n] == 0 do
            n = n - 1
        end
        dst.n = n
        dst.s = 1
    elseif carry > 0 then
        while carry > 0 do
            n = n + 1
            local q = math.floor(carry / BASE)
            dst[n] = carry - q * BASE
            carry = q
        end
        dst.n = n
        dst.s = 1
    else
        -- negative value: limbs hold S with value S - t*BASE^n, magnitude t*BASE^n - S
        local t = -carry
        local c2 = 1
        for i = 1, n do
            local v = BASE - 1 - dst[i] + c2
            if v >= BASE then
                v = v - BASE
                c2 = 1
            else
                c2 = 0
            end
            dst[i] = v
        end
        n = n + 1
        dst[n] = t - 1 + c2
        while n > 0 and dst[n] == 0 do
            n = n - 1
        end
        dst.n = n
        dst.s = -1
    end
    return dst
end

-- floor(|u| / |v|), magnitudes, |v| > 0; returns the quotient and whether it is exact.
-- The quotient is a single digit here, so one estimate plus a short correction suffices.
local function bqmag(u, v, s1, s2)
    local un, vn = u.n, v.n
    if un < vn then
        return 0, false
    end
    local shift = un - vn
    local a = u[un] * BASE + (un > 1 and u[un - 1] or 0)
    local b = v[vn] * BASE + (vn > 1 and v[vn - 1] or 0)
    local q
    if shift == 0 then
        q = math.floor(a / b)
    else
        local p = BASE
        for _ = 2, shift do
            p = p * BASE
        end
        q = math.floor((a / b) * p)
    end
    local cur = s1
    bmul(cur, v, q)
    while bcmpmag(cur, u) > 0 do
        q = q - 1
        bmul(cur, v, q)
    end
    while true do
        bmul(s2, v, q + 1)
        if bcmpmag(s2, u) <= 0 then
            q = q + 1
            cur = s2
            s2 = s1
            s1 = cur
        else
            break
        end
    end
    return q, bcmpmag(cur, u) == 0
end

-- floor(num / den) with den > 0
local function bfloorq(num, den, s1, s2)
    if num.n == 0 then
        return 0
    end
    local q, exact = bqmag(num, den, s1, s2)
    if num.s > 0 or exact then
        return q
    end
    return -q - 1
end

local BQ, BR, BT = { n = 0, s = 1 }, { n = 0, s = 1 }, { n = 0, s = 1 }
local A, B, C, D = { n = 0, s = 1 }, { n = 0, s = 1 }, { n = 0, s = 1 }, { n = 0, s = 1 }
local S1, S2 = { n = 0, s = 1 }, { n = 0, s = 1 }

-- state: q = 1, r = 0, t = 1, k = 1, n = 3, l = 3
BQ[1], BQ.n = 1, 1
BT[1], BT.n = 1, 1

local k, n, l = 1, 3, 3
local emitted = 0
local digitsum = 0

while emitted < 10000 do
    -- 4*q + r - t < n*t  ->  emit n
    blin(A, BQ, 4, BR, 1, BT, -1)
    bmul(B, BT, n)
    if bcmp(A, B) < 0 then
        local oldn = n
        digitsum = digitsum + oldn
        emitted = emitted + 1
        -- n = floor(10*(3*q + r) / t) - 10*n
        blin(C, BQ, 30, BR, 10)
        local nnew = bfloorq(C, BT, S1, S2) - 10 * oldn
        -- q = 10*q ; r = 10*(r - n*t)
        bmul(BQ, BQ, 10)
        blin(BR, BR, 10, BT, -10 * oldn)
        n = nnew
    else
        -- n = floor((q*(7*k+2) + r*l) / (t*l))
        blin(C, BQ, 7 * k + 2, BR, l)
        bmul(D, BT, l)
        n = bfloorq(C, D, S1, S2)
        -- r = (2*q + r)*l ; q = q*k ; t = t*l ; k = k+1 ; l = l+2
        blin(B, BQ, 2, BR, 1)
        bmul(B, B, l)
        bmul(BQ, BQ, k)
        local tmp = BR
        BR = B
        B = tmp
        tmp = BT
        BT = D
        D = tmp
        k = k + 1
        l = l + 2
    end
end

print(digitsum)
