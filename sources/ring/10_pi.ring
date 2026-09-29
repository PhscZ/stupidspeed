# task 10 pi — expected output: 4470
# build: none (interpreted)    run: ring 10_pi.ring
# note: Ring has no big integer type, so the spigot state is kept in hand-rolled big
#       integers, exactly as README.md allows: sign-magnitude, little-endian, base 1e9.
#       Only the operations the spigot needs exist here — add, subtract, multiply by a small
#       integer, and a quotient by repeated subtraction, which is always one decimal digit.
# note: Ring has no big integer type. The Ring repository ships a bignumber library
#       (libraries/bignumber, a Ring-level class doing schoolbook arithmetic on decimal
#       digit strings with a generic division), but the Light Release does not include it,
#       and it was rejected in any case: base 10 with a general quotient is strictly more
#       work per operation than base-1e9 limbs. The a68g row records the same rejection of
#       its own bignum mode.
# note: Ring numbers are doubles, so a limb holds a whole number below 1e9 and the products
#       stay exact: the largest multiplier the spigot asks for is about 7k+2, k stays in the
#       low thousands for 1000 digits, so limb * m + carry stays below 4e13, far under 2^53.
#       The quotient of a limb product by 1e9 is taken as (p - p % 1e9) / 1e9, which is exact
#       in a double, rather than through floor(p / 1e9).
# note: a Big is a Ring list: x[1] is the sign (0 or 1), x[2] upwards are the limbs, least
#       significant first, with no leading zero limb. Assigning a list in Ring copies it, so
#       the arithmetic functions below are pure and return new values.
# note: every local variable inside a function is prefixed with 'b'. Ring's scope rule is
#       that an assignment inside a function to a name that already exists in the global
#       scope writes to the global, not to a function-local variable (parameters are the
#       exception: they shadow). Without the prefix, the helper named 'q' below would have
#       overwritten the spigot's own q. That is a Ring gotcha, not a property of this
#       algorithm.

q = big_set(1)
r = big_set(0)
t = big_set(1)

k = 1
l = 3
n = 3
sum = 0
produced = 0

while produced < 1000
    u = big_mul_small(q, 4)
    u = big_add(u, r)
    v = big_mul_small(t, n + 1)

    if big_cmp(u, v) < 0
        # the digit n is settled
        sum = sum + n
        produced = produced + 1

        u = big_mul_small(q, 3)
        u = big_add(u, r)
        u = big_mul_small(u, 10)
        nxt = big_quot(u, t) - 10 * n

        v = big_mul_small(t, n)
        v = big_sub(r, v)
        r = big_mul_small(v, 10)
        q = big_mul_small(q, 10)
        n = nxt
    else
        # not settled yet: widen the state by one more term
        u = big_mul_small(q, 7 * k + 2)
        v = big_mul_small(r, l)
        u = big_add(u, v)
        v = big_mul_small(t, l)
        nxt = big_quot(u, v)

        u = big_mul_small(q, 2)
        u = big_add(u, r)
        u = big_mul_small(u, l)
        r = u
        q = big_mul_small(q, k)
        t = big_mul_small(t, l)

        k = k + 1
        l = l + 2
        n = nxt
    ok
end

? sum

func big_set bnum
    bx = list(1)
    bx[1] = 0
    while bnum > 0
        add(bx, bnum % 1000000000)
        bnum = (bnum - bnum % 1000000000) / 1000000000
    end
    return bx

# drop the leading zero limbs; a value with no limbs left is zero
func big_trim bx
    while len(bx) > 1 and bx[len(bx)] = 0
        del(bx, len(bx))
    end
    if len(bx) = 1
        bx[1] = 0
    ok
    return bx

func big_cmp_mag ba, bb
    bna = len(ba) - 1
    bnb = len(bb) - 1
    if bna != bnb
        if bna < bnb
            return -1
        else
            return 1
        ok
    ok
    for bi = bna to 1 step -1
        if ba[bi + 1] != bb[bi + 1]
            if ba[bi + 1] < bb[bi + 1]
                return -1
            else
                return 1
            ok
        ok
    next
    return 0

func big_cmp ba, bb
    if ba[1] != bb[1]
        if ba[1] = 1
            return -1
        else
            return 1
        ok
    ok
    bc = big_cmp_mag(ba, bb)
    if ba[1] = 1
        return -bc
    ok
    return bc

func big_add_mag ba, bb
    bna = len(ba) - 1
    bnb = len(bb) - 1
    bn = bna
    if bnb > bn
        bn = bnb
    ok
    bres = list(bn + 2)
    bres[1] = 0
    bcarry = 0
    for bi = 1 to bn
        bs = bcarry
        if bi <= bna
            bs = bs + ba[bi + 1]
        ok
        if bi <= bnb
            bs = bs + bb[bi + 1]
        ok
        if bs >= 1000000000
            bs = bs - 1000000000
            bcarry = 1
        else
            bcarry = 0
        ok
        bres[bi + 1] = bs
    next
    bres[bn + 2] = bcarry
    return big_trim(bres)

# requires a >= b, both non-negative
func big_sub_mag ba, bb
    bres = list(len(ba))
    bres[1] = 0
    bnb = len(bb) - 1
    bborrow = 0
    for bi = 1 to len(ba) - 1
        bbi = bborrow
        if bi <= bnb
            bbi = bbi + bb[bi + 1]
        ok
        bai = ba[bi + 1]
        if bai >= bbi
            bres[bi + 1] = bai - bbi
            bborrow = 0
        else
            bres[bi + 1] = bai + 1000000000 - bbi
            bborrow = 1
        ok
    next
    return big_trim(bres)

func big_add ba, bb
    if ba[1] = bb[1]
        bres = big_add_mag(ba, bb)
        bres[1] = ba[1]
        return big_trim(bres)
    ok
    if big_cmp_mag(ba, bb) >= 0
        bres = big_sub_mag(ba, bb)
        bres[1] = ba[1]
        return big_trim(bres)
    ok
    bres = big_sub_mag(bb, ba)
    bres[1] = bb[1]
    return big_trim(bres)

func big_sub ba, bb
    if ba[1] != bb[1]
        bres = big_add_mag(ba, bb)
        bres[1] = ba[1]
        return big_trim(bres)
    ok
    if big_cmp_mag(ba, bb) >= 0
        bres = big_sub_mag(ba, bb)
        bres[1] = ba[1]
        return big_trim(bres)
    ok
    bres = big_sub_mag(bb, ba)
    bres[1] = 1 - ba[1]
    return big_trim(bres)

func big_mul_small ba, bm
    if bm = 0 or len(ba) = 1
        bz = list(1)
        bz[1] = 0
        return bz
    ok
    bres = list(len(ba) + 1)
    bres[1] = ba[1]
    bcarry = 0
    for bi = 1 to len(ba) - 1
        bp = ba[bi + 1] * bm + bcarry
        bres[bi + 1] = bp % 1000000000
        bcarry = (bp - bp % 1000000000) / 1000000000
    next
    bn = len(ba)
    while bcarry > 0
        bv = bcarry % 1000000000
        bcarry = (bcarry - bv) / 1000000000
        if bn + 1 <= len(bres)
            bres[bn + 1] = bv
        else
            add(bres, bv)
        ok
        bn = bn + 1
    end
    return big_trim(bres)

# floor(a / b) for a >= 0 and b > 0, by repeated subtraction: the spigot only ever asks for
# a quotient of one decimal digit, so counting how many times b fits into a is enough
func big_quot ba, bb
    bq = 0
    if ba[1] = 1 or bb[1] = 1 or len(bb) = 1
        return 0
    ok
    bwork = bb
    while big_cmp(ba, bwork) >= 0
        bq = bq + 1
        bwork = big_add_mag(bwork, bb)
    end
    return bq
