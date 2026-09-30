-- task 10 pi — expected output: 4470
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc terra.exe 10_pi.t     (from sources/terra/)
-- note: VCINSTALLDIR is mandatory and is the switch, not a path — terralib aborts with
--       "Can't find windows SDK version 8.1 or 10!" and exit 1 before it opens this file
--       unless it finds a Visual Studio developer console or the Windows Kits registry key.
--       See temp/terra-doc.md §3. This file needs no INCLUDE: it includes no C header.
-- note: DEVIATION, shared with the C, VBScript, OCaml, Octave, Janet, Ring, JScript,
--       AutoHotkey and VHDL rows: there is no arbitrary-precision integer here. Lua
--       5.1/LuaJIT's math library is entirely double-based — `2^53 + 1 == 2^53` is true —
--       Terra's widest integer is 64 bits, and `require("bignum")`, `require("bigint")` and
--       `require("math.big")` all fail. So the spigot's state is hand-written sign-magnitude
--       little-endian base-1e9 limbs, exactly the shape sources/c/10_pi.c uses.
-- note: THE ARITHMETIC ARGUMENT, which is what makes int64 sufficient. A limb is at most
--       10^9 - 1. The only operation that can overflow is limb * scalar + carry, and the
--       spigot's only unbounded scalars are its own loop variables k and l. Instrumented at
--       1000 digits, k reaches 3314 and l reaches 6629, so the largest scalar ever applied
--       to a multi-limb value is 6629, giving a worst intermediate of
--       (10^9 - 1) * 6629 + 6629 = 6.629e12 — 1.39 million times below int64's 9.223e18.
--       Two-limb additions stay under 2e9, the digit quotient is one decimal digit obtained
--       by at most ten bignum subtractions, and nothing else in the loop exceeds those.
--       Every intermediate is therefore exact, with five orders of magnitude of margin, and
--       no 128-bit type and no overflow check is needed. temp/terra-doc.md §14.
-- note: the limbs are uint64, and the base is 1e9, so `p % BASE` and `p / BASE` are the
--       limb split and are unsigned divisions — the same trick the C row uses.
-- note: capacity is a fixed 1500 limbs per value, allocated once from terralib.new and
--       sliced into six Bigs. Instrumented, the widest state at 1000 digits is 1248 limbs
--       (q, r and t all reach about 11226 decimal digits), so 1500 leaves 20% headroom. The
--       C row grows its arrays instead; a fixed capacity is simpler here and cannot fail at
--       this digit count.
-- note: the digits are never printed, only their sum, so the check is one number, as the
--       spec asks. Verified: 1000 digits give 4470, and the same instrumented run gives the
--       independent values 39 at 10 digits, 471 at 100, 897 at 200 and 1753 at 400.
-- note: r really does go negative — the state is signed, not merely non-negative — which is
--       why the sign flag and the sign-aware add/subtract/compare are here rather than a
--       magnitude-only implementation.

struct Big { n : int; neg : int; limb : &uint64 }

terra big_trim(x : &Big)
    while x.n > 0 and x.limb[x.n - 1] == 0ULL do
        x.n = x.n - 1
    end
    if x.n == 0 then
        x.neg = 0
    end
end

terra big_set(x : &Big, v : uint64)
    x.n = 0
    x.neg = 0
    while v > 0ULL do
        x.limb[x.n] = v % 1000000000ULL
        x.n = x.n + 1
        v = v / 1000000000ULL
    end
end

terra big_copy(dst : &Big, src : &Big)
    for i = 0, src.n do
        dst.limb[i] = src.limb[i]
    end
    dst.n = src.n
    dst.neg = src.neg
end

terra big_cmp_mag(a : &Big, b : &Big) : int
    if a.n ~= b.n then
        if a.n < b.n then return -1 end
        return 1
    end
    var i = a.n - 1
    while i >= 0 do
        if a.limb[i] ~= b.limb[i] then
            if a.limb[i] < b.limb[i] then return -1 end
            return 1
        end
        i = i - 1
    end
    return 0
end

terra big_cmp(a : &Big, b : &Big) : int
    if a.neg ~= b.neg then
        if a.neg == 1 then return -1 end
        return 1
    end
    var c = big_cmp_mag(a, b)
    if a.neg == 1 then
        return -c
    end
    return c
end

terra big_add_mag(r : &Big, a : &Big, b : &Big)
    var carry : uint64 = 0ULL
    var n = a.n
    if b.n > n then n = b.n end
    for i = 0, n do
        var x : uint64 = carry
        if i < a.n then x = x + a.limb[i] end
        if i < b.n then x = x + b.limb[i] end
        r.limb[i] = x % 1000000000ULL
        carry = x / 1000000000ULL
    end
    var nn = n
    if carry > 0ULL then
        r.limb[nn] = carry
        nn = nn + 1
    end
    r.n = nn
    r.neg = 0
end

terra big_sub_mag(r : &Big, a : &Big, b : &Big)   -- requires |a| >= |b|
    var borrow : int64 = 0
    for i = 0, a.n do
        var x : int64 = [int64](a.limb[i]) - borrow
        if i < b.n then
            x = x - [int64](b.limb[i])
        end
        if x < 0 then
            x = x + 1000000000LL
            borrow = 1
        else
            borrow = 0
        end
        r.limb[i] = [uint64](x)
    end
    r.n = a.n
    r.neg = 0
    big_trim(r)
end

terra big_add(r : &Big, a : &Big, b : &Big)
    if a.neg == b.neg then
        big_add_mag(r, a, b)
        r.neg = a.neg
    elseif big_cmp_mag(a, b) >= 0 then
        big_sub_mag(r, a, b)
        r.neg = a.neg
    else
        big_sub_mag(r, b, a)
        r.neg = b.neg
    end
    big_trim(r)
end

terra big_sub(r : &Big, a : &Big, b : &Big)       -- r = a - b
    if a.neg ~= b.neg then
        big_add_mag(r, a, b)
        r.neg = a.neg
    elseif big_cmp_mag(a, b) >= 0 then
        big_sub_mag(r, a, b)
        r.neg = a.neg
    else
        big_sub_mag(r, b, a)
        r.neg = 1 - a.neg
    end
    big_trim(r)
end

terra big_mul_small(r : &Big, a : &Big, m : uint64)
    if m == 0ULL or a.n == 0 then
        r.n = 0
        r.neg = 0
        return
    end
    var carry : uint64 = 0ULL
    for i = 0, a.n do
        var p : uint64 = a.limb[i] * m + carry
        r.limb[i] = p % 1000000000ULL
        carry = p / 1000000000ULL
    end
    var n = a.n
    while carry > 0ULL do
        r.limb[n] = carry % 1000000000ULL
        carry = carry / 1000000000ULL
        n = n + 1
    end
    r.n = n
    r.neg = a.neg
    big_trim(r)
end

-- floor(a / b) for a >= 0, b > 0. The spigot only ever asks for a quotient of one decimal
-- digit, so counting how many times b fits into a is enough — the same choice the C row
-- makes, and the reason no long division is needed anywhere in this file.
terra big_quot(a : &Big, b : &Big, work : &Big) : uint64
    var q : uint64 = 0ULL
    if a.neg == 1 or b.neg == 1 or b.n == 0 then
        return 0ULL
    end
    big_copy(work, b)
    while big_cmp(a, work) >= 0 do
        q = q + 1ULL
        big_add_mag(work, work, b)
    end
    return q
end

terra pi_digit_sum(ndigits : int64, arena : &uint64, cap : int64) : uint64
    var q : Big
    var r : Big
    var t : Big
    var u : Big
    var v : Big
    var w : Big
    q.limb = arena
    r.limb = arena + cap
    t.limb = arena + 2 * cap
    u.limb = arena + 3 * cap
    v.limb = arena + 4 * cap
    w.limb = arena + 5 * cap

    big_set(&q, 1ULL)
    big_set(&r, 0ULL)
    big_set(&t, 1ULL)

    var k : uint64 = 1ULL
    var l : uint64 = 3ULL
    var n : uint64 = 3ULL
    var sum : uint64 = 0ULL

    var produced : int64 = 0
    while produced < ndigits do
        big_mul_small(&u, &q, 4ULL)
        big_add(&u, &u, &r)                  -- u = 4q + r
        big_mul_small(&v, &t, n + 1ULL)      -- v = (n + 1) t

        if big_cmp(&u, &v) < 0 then
            -- the digit n is settled
            sum = sum + n
            produced = produced + 1

            big_mul_small(&u, &q, 3ULL)
            big_add(&u, &u, &r)
            big_mul_small(&u, &u, 10ULL)     -- u = 10 (3q + r)
            var next : uint64 = big_quot(&u, &t, &w) - 10ULL * n

            big_mul_small(&v, &t, n)         -- v = n t
            big_sub(&v, &r, &v)              -- v = r - n t
            big_mul_small(&r, &v, 10ULL)     -- r = 10 (r - n t)
            big_mul_small(&q, &q, 10ULL)     -- q = 10q, t unchanged

            n = next
        else
            -- not settled yet: widen the state by one more term
            big_mul_small(&u, &q, 7ULL * k + 2ULL)
            big_mul_small(&v, &r, l)
            big_add(&u, &u, &v)              -- u = q (7k + 2) + r l
            big_mul_small(&v, &t, l)         -- v = t l
            var next : uint64 = big_quot(&u, &v, &w)

            big_mul_small(&u, &q, 2ULL)
            big_add(&u, &u, &r)
            big_mul_small(&u, &u, l)         -- u = (2q + r) l
            big_copy(&r, &u)
            big_mul_small(&q, &q, k)
            big_mul_small(&t, &t, l)

            k = k + 1ULL
            l = l + 2ULL
            n = next
        end
    end

    return sum
end

local CAP = 1500
local arena = terralib.new(uint64[6 * CAP])

print(string.format("%d", pi_digit_sum(1000, arena, CAP)))
