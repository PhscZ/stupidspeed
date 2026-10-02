-- task 10 pi — expected output: 4470
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 10_pi.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 10_pi.luau
-- Luau has no arbitrary-precision integers (the integer library's 64-bit values stop at 2^64), so
-- this is the hand-rolled route: sign-magnitude, little-endian, base-1e9 limbs with add, subtract,
-- multiply by a small integer, and a quotient that comes out of repeated subtraction.
-- Gibbons' unbounded spigot is the fixed algorithm, the same loop every row runs.
-- The state is (q, r, t, k, n, l); r is the one that goes negative, which is why the limbs carry a
-- sign. Every multiplication is by a small integer (10, k, l, 7k+2, n) so a limb times the
-- multiplier plus the carry stays far below 2^53: at 1000 digits k reaches 3314 and l 6629, and
-- 1e9 * 23200 is 2.3e13. Both divisions have a small quotient - the widest over the whole run is
-- 99 - so repeated subtraction is enough, and no general long division is needed.

local BASE = 1000000000

local function zero()
    return { sign = 1, len = 1, limbs = { 0 } }
end

-- v >= 0 and small
local function fromSmall(v)
    local limbs = {}
    local len = 0
    repeat
        len = len + 1
        local q = math.floor(v / BASE)
        limbs[len] = v - q * BASE
        v = q
    until v == 0
    return { sign = 1, len = len, limbs = limbs }
end

local function normalize(a)
    local limbs = a.limbs
    local len = a.len
    while len > 1 and limbs[len] == 0 do
        limbs[len] = nil
        len = len - 1
    end
    a.len = len
    if len == 1 and limbs[1] == 0 then
        a.sign = 1
    end
    return a
end

-- |a| against |b|
local function cmpMag(a, b)
    if a.len ~= b.len then
        return a.len < b.len and -1 or 1
    end
    local al, bl = a.limbs, b.limbs
    for i = a.len, 1, -1 do
        local x, y = al[i], bl[i]
        if x ~= y then
            return x < y and -1 or 1
        end
    end
    return 0
end

local function cmp(a, b)
    if a.sign ~= b.sign then
        return a.sign < b.sign and -1 or 1
    end
    return cmpMag(a, b) * a.sign
end

local function addMag(a, b)
    local al, bl = a.limbs, b.limbs
    local len = math.max(a.len, b.len)
    local limbs = {}
    local carry = 0
    for i = 1, len do
        local t = (al[i] or 0) + (bl[i] or 0) + carry
        if t >= BASE then
            limbs[i] = t - BASE
            carry = 1
        else
            limbs[i] = t
            carry = 0
        end
    end
    if carry > 0 then
        len = len + 1
        limbs[len] = carry
    end
    return { sign = 1, len = len, limbs = limbs }
end

-- |a| - |b|, requires |a| >= |b|
local function subMag(a, b)
    local al, bl = a.limbs, b.limbs
    local limbs = {}
    local borrow = 0
    for i = 1, a.len do
        local t = al[i] - borrow - (bl[i] or 0)
        if t < 0 then
            limbs[i] = t + BASE
            borrow = 1
        else
            limbs[i] = t
            borrow = 0
        end
    end
    return normalize({ sign = 1, len = a.len, limbs = limbs })
end

-- |a| := |a| - |b| in place, the same requirement on the operands
local function subMagInPlace(a, b)
    local al, bl = a.limbs, b.limbs
    local borrow = 0
    for i = 1, a.len do
        local t = al[i] - borrow - (bl[i] or 0)
        if t < 0 then
            al[i] = t + BASE
            borrow = 1
        else
            al[i] = t
            borrow = 0
        end
    end
    return normalize(a)
end

local function add(a, b)
    if a.sign == b.sign then
        local r = addMag(a, b)
        r.sign = a.sign
        return r
    end
    local c = cmpMag(a, b)
    if c == 0 then
        return zero()
    elseif c > 0 then
        local r = subMag(a, b)
        r.sign = a.sign
        return r
    else
        local r = subMag(b, a)
        r.sign = b.sign
        return r
    end
end

local function sub(a, b)
    return add(a, { sign = -b.sign, len = b.len, limbs = b.limbs })
end

-- a * k, k a non-negative small integer
local function mulSmall(a, k)
    if k == 0 then
        return zero()
    end
    local al = a.limbs
    local len = a.len
    local limbs = {}
    local carry = 0
    for i = 1, len do
        local t = al[i] * k + carry
        local q = math.floor(t / BASE)
        limbs[i] = t - q * BASE
        carry = q
    end
    while carry > 0 do
        len = len + 1
        local q = math.floor(carry / BASE)
        limbs[len] = carry - q * BASE
        carry = q
    end
    return { sign = a.sign, len = len, limbs = limbs }
end

-- a >= 0, b > 0, and a / b is a small integer: count how many times b comes out of a.
-- a is consumed; the remainder is discarded, because the spigot only ever wants the quotient.
local function divQuotientSmall(a, b)
    local q = 0
    while cmpMag(a, b) >= 0 do
        subMagInPlace(a, b)
        q = q + 1
    end
    return q
end

local digits = 1000
local q, r, t = fromSmall(1), zero(), fromSmall(1)
local k, n, l = 1, 3, 3

local sum = 0
local emitted = 0
while emitted < digits do
    -- if 4*q + r - t < n*t then emit n
    if cmp(sub(add(mulSmall(q, 4), r), t), mulSmall(t, n)) < 0 then
        sum = sum + n
        emitted = emitted + 1
        -- q, r, t, k, n, l = 10*q, 10*(r-n*t), t, k, (10*(3*q+r))/t - 10*n, l
        local nq = mulSmall(q, 10)
        local nr = mulSmall(sub(r, mulSmall(t, n)), 10)
        local nn = divQuotientSmall(mulSmall(add(mulSmall(q, 3), r), 10), t) - 10 * n
        q, r, n = nq, nr, nn
    else
        -- q, r, t, k, n, l = q*k, (2*q+r)*l, t*l, k+1, (q*(7*k+2)+r*l)/(t*l), l+2
        local nq = mulSmall(q, k)
        local nr = mulSmall(add(mulSmall(q, 2), r), l)
        local nt = mulSmall(t, l)
        local nn = divQuotientSmall(add(mulSmall(q, 7 * k + 2), mulSmall(r, l)), nt)
        q, r, t, n = nq, nr, nt, nn
        k = k + 1
        l = l + 2
    end
end

print(sum)
