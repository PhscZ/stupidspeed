' task 10 pi -- expected output: 44889
' build: fbc -O 2 -x 10_pi.bas    run: ./10_pi.exe
' task 10 pi - 10000 digits, Gibbons unbounded spigot on hand-rolled base-1e9 limbs.
' FreeBASIC has no big integers, so this is the GDScript/Pascal precedent: sign-magnitude
' big integers with the four operations the spigot needs. Only the digit sum is printed.
' Expected 44889.

const LIMB_BASE as longint = 1000000000
const NDIGITS as integer = 10000
const NLIMBS as integer = 17000      ' t reaches 145726 decimal digits -> 16192 limbs
const QUOT_HI as longint = 1023      ' true quotients observed <= 99

type Big
    neg as integer                   ' 0 or 1; a zero value always has neg = 0
    n as integer                     ' limb count, >= 1
    d(0 to NLIMBS-1) as longint
end type

dim shared as Big q, r, t, nt, lhs, tl
dim shared as Big tmp1, tmp2, tmp3, probe

sub trim(byref a as Big)
    while a.n > 1 andalso a.d(a.n - 1) = 0
        a.n -= 1
    wend
    if a.n = 1 andalso a.d(0) = 0 then a.neg = 0
end sub

sub copy_big(byref o as Big, byref a as Big)
    dim as integer i
    for i = 0 to a.n - 1
        o.d(i) = a.d(i)
    next
    o.n = a.n
    o.neg = a.neg
end sub

function mag_cmp(byref a as Big, byref b as Big) as integer
    if a.n <> b.n then return iif(a.n > b.n, 1, -1)
    dim as integer i
    for i = a.n - 1 to 0 step -1
        if a.d(i) <> b.d(i) then return iif(a.d(i) > b.d(i), 1, -1)
    next
    return 0
end function

function cmp_big(byref a as Big, byref b as Big) as integer
    if a.neg <> b.neg then return iif(a.neg, -1, 1)
    dim as integer c = mag_cmp(a, b)
    return iif(a.neg, -c, c)
end function

' o = |a| + |b|
sub mag_add(byref o as Big, byref a as Big, byref b as Big)
    dim as longint carry = 0
    dim as integer i, nn
    nn = iif(a.n > b.n, a.n, b.n)
    for i = 0 to nn - 1
        dim as longint cur = carry
        if i < a.n then cur += a.d(i)
        if i < b.n then cur += b.d(i)
        o.d(i) = cur mod LIMB_BASE
        carry = cur \ LIMB_BASE
    next
    o.d(nn) = carry
    o.n = nn + 1
    o.neg = 0
    trim(o)
end sub

' o = |a| - |b|, requires |a| >= |b|
sub mag_sub(byref o as Big, byref a as Big, byref b as Big)
    dim as longint borrow = 0
    dim as integer i
    for i = 0 to a.n - 1
        dim as longint cur = a.d(i) - borrow
        if i < b.n then cur -= b.d(i)
        if cur < 0 then
            cur += LIMB_BASE
            borrow = 1
        else
            borrow = 0
        end if
        o.d(i) = cur
    next
    o.n = a.n
    o.neg = 0
    trim(o)
end sub

' o = a + b, signed
sub add_big(byref o as Big, byref a as Big, byref b as Big)
    if a.neg = b.neg then
        mag_add(o, a, b)
        o.neg = a.neg
        trim(o)
        exit sub
    end if
    dim as integer c = mag_cmp(a, b)
    if c = 0 then
        o.n = 1 : o.d(0) = 0 : o.neg = 0
        exit sub
    end if
    if c > 0 then
        mag_sub(o, a, b)
        o.neg = a.neg
    else
        mag_sub(o, b, a)
        o.neg = b.neg
    end if
    trim(o)
end sub

' o = a - b, signed
sub sub_big(byref o as Big, byref a as Big, byref b as Big)
    dim as Big nb
    copy_big(nb, b)
    if nb.n > 1 orelse nb.d(0) <> 0 then nb.neg = 1 - nb.neg
    add_big(o, a, nb)
end sub

' o = a * m, m >= 0, sign preserved
sub mul_small(byref o as Big, byref a as Big, byval m as longint)
    if m = 0 orelse (a.n = 1 andalso a.d(0) = 0) then
        o.n = 1 : o.d(0) = 0 : o.neg = 0
        exit sub
    end if
    dim as longint carry = 0
    dim as integer i
    for i = 0 to a.n - 1
        dim as longint cur = a.d(i) * m + carry
        o.d(i) = cur mod LIMB_BASE
        carry = cur \ LIMB_BASE
    next
    o.d(a.n) = carry
    o.n = a.n + 1
    o.neg = a.neg
    trim(o)
end sub

' floor(a / b) for a >= 0, b > 0, with the true quotient known to be <= hi.
' Binary search over [0, hi] on |b|*est against |a|: no big-by-big division needed.
function div_quot(byref a as Big, byref b as Big, byval hi as longint) as longint
    if a.n < b.n then return 0
    dim as longint lo = 0, mid
    dim as longint high = hi
    do while lo < high
        mid = lo + (high - lo + 1) \ 2
        mul_small(probe, b, mid)
        if mag_cmp(probe, a) <= 0 then
            lo = mid
        else
            high = mid - 1
        end if
    loop
    return lo
end function

' ---- main ----
q.n = 1 : q.d(0) = 1 : q.neg = 0
r.n = 1 : r.d(0) = 0 : r.neg = 0
t.n = 1 : t.d(0) = 1 : t.neg = 0

dim as longint k = 1
dim as longint n = 3
dim as longint l = 3
dim as longint total = 0
dim as longint emitted = 0

do while emitted < NDIGITS
    mul_small(nt, t, n)                 ' nt = n*t
    mul_small(tmp1, q, 4)               ' tmp1 = 4q
    add_big(tmp2, tmp1, r)              ' tmp2 = 4q + r
    sub_big(lhs, tmp2, t)               ' lhs = 4q + r - t   (may be negative)
    if cmp_big(lhs, nt) < 0 then
        ' digit n is settled
        total += n
        emitted += 1
        mul_small(tmp1, q, 3)           ' 3q
        add_big(tmp2, tmp1, r)          ' 3q + r   (never negative)
        mul_small(tmp3, tmp2, 10)       ' 10*(3q + r)
        dim as longint nextn = div_quot(tmp3, t, QUOT_HI) - 10 * n
        mul_small(tmp1, q, 10)          ' q = 10q
        copy_big(q, tmp1)
        sub_big(tmp2, r, nt)            ' r - n*t   (may be negative)
        mul_small(tmp1, tmp2, 10)       ' r = 10*(r - n*t)
        copy_big(r, tmp1)
        n = nextn
    else
        mul_small(tmp1, q, 7 * k + 2)   ' q*(7k+2)
        mul_small(tmp2, r, l)           ' r*l   (sign of r)
        add_big(tmp3, tmp1, tmp2)       ' numerator  (never negative)
        mul_small(tl, t, l)             ' denominator = t*l
        n = div_quot(tmp3, tl, QUOT_HI)
        mul_small(tmp1, q, k)           ' q = q*k
        copy_big(q, tmp1)
        mul_small(tmp1, q, 2)           ' 2q
        add_big(tmp2, tmp1, r)          ' 2q + r
        mul_small(tmp1, tmp2, l)        ' r = (2q + r)*l
        copy_big(r, tmp1)
        copy_big(t, tl)                 ' t = t*l
        k += 1
        l += 2
    end if
loop

print str(total)
