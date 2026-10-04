// task 10 pi — expected output: 4470
// build: none (interpreted)    run: lobster 10_pi.lobster
//
// Lobster's int is a 64-bit scalar with no arbitrary precision, so this is the same
// Gibbons unbounded spigot as the C reference, with hand-written sign-magnitude big
// integers: little-endian limbs base 1e9.  Only the operations the spigot needs are
// implemented: add, subtract, multiply by a small int (limb * small + carry stays
// well inside 64 bits) and a single-digit quotient, which comes out of repeated
// subtraction.

// timing: seconds_elapsed() is the VM's monotonic clock (QueryPerformanceCounter on Windows).
// Lobster has no stderr, so the contract's fallback applies: TIME_MS is written to time.txt.
let t_start = seconds_elapsed()

let BASE = 1000000000

class Big:
    limb:[int]
    neg:int

def big_new(v:int) -> Big:
    let b = Big { []::int, 0 }
    big_set(b, v)
    return b

def big_set(b:Big, v:int):
    b.limb = []::int
    b.neg = 0
    if v == 0: return
    if v < 0:
        b.neg = 1
        v = -v
    while v > 0:
        push(b.limb, v % BASE)
        v /= BASE

def big_trim(b:Big):
    while b.limb.length > 0 and b.limb[b.limb.length - 1] == 0:
        pop(b.limb)
    if b.limb.length == 0: b.neg = 0

def big_copy(dst:Big, src:Big):
    dst.limb = copy(src.limb)
    dst.neg = src.neg

def big_cmp_mag(a:Big, b:Big) -> int:
    if a.limb.length != b.limb.length:
        return a.limb.length - b.limb.length
    var i = a.limb.length - 1
    while i >= 0:
        if a.limb[i] != b.limb[i]:
            return a.limb[i] - b.limb[i]
        i--
    return 0

def big_cmp(a:Big, b:Big) -> int:
    if a.neg != b.neg:
        return if a.neg: -1 else: 1
    let c = big_cmp_mag(a, b)
    return if a.neg: -c else: c

def big_add_mag(r:Big, a:Big, b:Big):
    // a, b >= 0
    let out = []::int
    let n = max(a.limb.length, b.limb.length)
    vector_capacity(out, n + 1)
    var carry = 0
    for(n) i:
        var s = carry
        if i < a.limb.length: s += a.limb[i]
        if i < b.limb.length: s += b.limb[i]
        push(out, s % BASE)
        carry = s / BASE
    if carry > 0: push(out, carry)
    r.limb = out
    r.neg = 0

def big_sub_mag(r:Big, a:Big, b:Big):
    // a >= b >= 0
    let out = []::int
    vector_capacity(out, a.limb.length)
    var borrow = 0
    for(a.limb.length) i:
        var s = a.limb[i] - borrow
        if i < b.limb.length: s -= b.limb[i]
        borrow = 0
        if s < 0:
            s += BASE
            borrow = 1
        push(out, s)
    r.limb = out
    r.neg = 0
    big_trim(r)

def big_add(r:Big, a:Big, b:Big):
    if a.neg == b.neg:
        big_add_mag(r, a, b)
        r.neg = a.neg
    elif big_cmp_mag(a, b) >= 0:
        big_sub_mag(r, a, b)
        r.neg = a.neg
    else:
        big_sub_mag(r, b, a)
        r.neg = b.neg
    big_trim(r)

def big_sub(r:Big, a:Big, b:Big):
    if a.neg != b.neg:
        big_add_mag(r, a, b)
        r.neg = a.neg
    elif big_cmp_mag(a, b) >= 0:
        big_sub_mag(r, a, b)
        r.neg = a.neg
    else:
        big_sub_mag(r, b, a)
        r.neg = 1 - a.neg
    big_trim(r)

def big_mul_small(r:Big, a:Big, m:int):
    if m == 0 or a.limb.length == 0:
        r.limb = []::int
        r.neg = 0
        return
    let out = []::int
    vector_capacity(out, a.limb.length + 2)
    var carry = 0
    for(a.limb.length) i:
        let p = a.limb[i] * m + carry
        push(out, p % BASE)
        carry = p / BASE
    while carry > 0:
        push(out, carry % BASE)
        carry /= BASE
    r.limb = out
    r.neg = a.neg
    big_trim(r)

def big_quot(a:Big, b:Big, work:Big) -> int:
    // floor(a / b) for a >= 0, b > 0; the quotient is only ever a few digits
    if a.neg or b.neg or b.limb.length == 0:
        return 0
    var q = 0
    big_copy(work, b)
    while big_cmp_mag(a, work) >= 0:
        q++
        big_add_mag(work, work, b)
    return q

let q = big_new(1)
let r = big_new(0)
let t = big_new(1)
let u = Big { []::int, 0 }
let v = Big { []::int, 0 }
let w = Big { []::int, 0 }

var k = 1
var l = 3
var n = 3
var sum = 0
var produced = 0

while produced < 1000:
    big_mul_small(u, q, 4)
    big_add(u, u, r)                 // u = 4q + r
    big_mul_small(v, t, n + 1)       // v = (n + 1)t

    if big_cmp(u, v) < 0:
        // the digit n is settled
        sum += n
        produced++

        big_mul_small(u, q, 3)
        big_add(u, u, r)
        big_mul_small(u, u, 10)              // u = 10(3q + r)
        let next = big_quot(u, t, w) - 10 * n

        big_mul_small(v, t, n)               // v = n t
        big_sub(v, r, v)                     // v = r - n t
        big_mul_small(r, v, 10)              // r = 10(r - n t)
        big_mul_small(q, q, 10)              // q = 10q, t is unchanged

        n = next
    else:
        // not settled yet: widen the state by one more term
        big_mul_small(u, q, 7 * k + 2)
        big_mul_small(v, r, l)
        big_add(u, u, v)                     // u = q(7k + 2) + r l
        big_mul_small(v, t, l)               // v = t l
        let next = big_quot(u, v, w)

        big_mul_small(u, q, 2)
        big_add(u, u, r)
        big_mul_small(u, u, l)               // u = (2q + r) l
        big_copy(r, u)
        big_mul_small(q, q, k)
        big_mul_small(t, t, l)

        k++
        l += 2
        n = next

write_file("time.txt", "TIME_MS=" + string((seconds_elapsed() - t_start) * 1000.0) + "\n")
print sum
