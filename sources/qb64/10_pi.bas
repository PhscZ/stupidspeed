' task 10 pi -- expected output: 4470
' build: qb64pe.exe -x 10_pi.bas -o prog.exe    run: prog.exe
' timing: _UPTIME (QB64-PE v4.7.0's high-resolution monotonic clock, seconds as a Double);
'         TIME_MS goes to stderr through the kernel32 WriteFile route below
'         (DECLARE DYNAMIC LIBRARY, GetStdHandle(-12)).
' note: 1000 digits of pi by Gibbons' unbounded spigot. QB64 has no arbitrary-precision
'       integers, so this is the hand-rolled route: sign-magnitude little-endian base-1e9
'       limbs in _INTEGER64 arrays with add, subtract, multiply-by-small and a quotient
'       found by binary search over [0, 1023] (the spigot only ever asks for a quotient
'       <= 99, verified against exact arithmetic in Python). 4096 limbs is far more than
'       the 1248 the run needs (t and q each reach 11223 decimal digits); the first
'       attempt used 1024 and died with "Subscript out of range". The digits themselves
'       are never printed, only their sum.
' stdout: written with the same WriteFile call on handle -11, with one LF as the trailing
'         newline and no CR, so the line is byte-for-byte the expected one. QB64's PRINT
'         would add CRLF and a leading space for positive numbers, so it is not used.
$CONSOLE:ONLY
DECLARE DYNAMIC LIBRARY "kernel32"
    FUNCTION GetStdHandle%& (BYVAL n AS LONG)
    FUNCTION WriteFile%& (BYVAL h AS _OFFSET, BYVAL b AS _OFFSET, BYVAL n AS _UNSIGNED LONG, BYVAL w AS _OFFSET, BYVAL o AS _OFFSET)
END DECLARE

CONST LIMB_BASE = 1000000000
CONST NDIGITS = 1000
CONST QUOT_HI = 1023

TYPE Big
    neg AS INTEGER                  ' 0 or 1; a zero value always has neg = 0
    n AS INTEGER                    ' limb count, >= 1
    d(0 TO 4095) AS _INTEGER64
END TYPE

DIM SHARED q AS Big, r AS Big, t AS Big, nt AS Big, lhs AS Big, tl AS Big
DIM SHARED tmp1 AS Big, tmp2 AS Big, tmp3 AS Big, probe AS Big

DIM t0 AS DOUBLE
t0 = _UPTIME

q.n = 1: q.d(0) = 1: q.neg = 0
r.n = 1: r.d(0) = 0: r.neg = 0
t.n = 1: t.d(0) = 1: t.neg = 0

DIM k AS _INTEGER64
DIM n AS _INTEGER64
DIM l AS _INTEGER64
DIM total AS _INTEGER64
DIM emitted AS _INTEGER64
k = 1
n = 3
l = 3

DO WHILE emitted < NDIGITS
    mul_small nt, t, n                 ' nt = n*t
    mul_small tmp1, q, 4               ' tmp1 = 4q
    add_big tmp2, tmp1, r              ' tmp2 = 4q + r
    sub_big lhs, tmp2, t               ' lhs = 4q + r - t   (may be negative)
    IF cmp_big%(lhs, nt) < 0 THEN
        ' digit n is settled; every update below still reads the state as it was on
        ' entry to the branch, so n is the quotient of the old q and r over the old t
        total = total + n
        emitted = emitted + 1
        mul_small tmp1, q, 3           ' 3q
        add_big tmp2, tmp1, r          ' 3q + r   (never negative)
        mul_small tmp3, tmp2, 10       ' 10*(3q + r)
        DIM nextn AS _INTEGER64
        nextn = div_quot&&(tmp3, t, QUOT_HI) - 10 * n
        mul_small tmp1, q, 10          ' q = 10q
        copy_big q, tmp1
        sub_big tmp2, r, nt            ' r - n*t   (may be negative)
        mul_small tmp1, tmp2, 10       ' r = 10*(r - n*t)
        copy_big r, tmp1
        n = nextn
    ELSE
        mul_small tmp1, q, 7 * k + 2   ' q*(7k+2)
        mul_small tmp2, r, l           ' r*l   (sign of r)
        add_big tmp3, tmp1, tmp2       ' numerator (never negative)
        mul_small tl, t, l             ' denominator = t*l
        n = div_quot&&(tmp3, tl, QUOT_HI)
        mul_small tmp1, q, 2           ' 2q -- the *old* q: r is (2q + r)*l, and q is
        add_big tmp2, tmp1, r          ' 2q + r   only scaled by k afterwards
        mul_small tmp1, tmp2, l        ' r = (2q + r)*l
        copy_big r, tmp1
        mul_small tmp1, q, k           ' q = q*k
        copy_big q, tmp1
        copy_big t, tl                 ' t = t*l
        k = k + 1
        l = l + 2
    END IF
LOOP

DIM msv AS DOUBLE
msv = (_UPTIME - t0) * 1000
emit_time msv
say LTRIM$(STR$(total))
SYSTEM

SUB big_trim (a AS Big)
    DO WHILE a.n > 1 _ANDALSO a.d(a.n - 1) = 0
        a.n = a.n - 1
    LOOP
    IF a.n = 1 _ANDALSO a.d(0) = 0 THEN a.neg = 0
END SUB

SUB copy_big (o AS Big, a AS Big)
    DIM i AS INTEGER
    FOR i = 0 TO a.n - 1
        o.d(i) = a.d(i)
    NEXT
    o.n = a.n
    o.neg = a.neg
END SUB

FUNCTION mag_cmp% (a AS Big, b AS Big)
    IF a.n <> b.n THEN
        IF a.n > b.n THEN mag_cmp = 1 ELSE mag_cmp = -1
        EXIT FUNCTION
    END IF
    DIM i AS INTEGER
    FOR i = a.n - 1 TO 0 STEP -1
        IF a.d(i) <> b.d(i) THEN
            IF a.d(i) > b.d(i) THEN mag_cmp = 1 ELSE mag_cmp = -1
            EXIT FUNCTION
        END IF
    NEXT
    mag_cmp = 0
END FUNCTION

FUNCTION cmp_big% (a AS Big, b AS Big)
    IF a.neg <> b.neg THEN
        IF a.neg THEN cmp_big = -1 ELSE cmp_big = 1
        EXIT FUNCTION
    END IF
    DIM c AS INTEGER
    c = mag_cmp%(a, b)
    IF a.neg THEN cmp_big = -c ELSE cmp_big = c
END FUNCTION

' o = |a| + |b|
SUB mag_add (o AS Big, a AS Big, b AS Big)
    DIM carry AS _INTEGER64
    DIM i AS INTEGER, nn AS INTEGER
    IF a.n > b.n THEN nn = a.n ELSE nn = b.n
    carry = 0
    FOR i = 0 TO nn - 1
        DIM cur AS _INTEGER64
        cur = carry
        IF i < a.n THEN cur = cur + a.d(i)
        IF i < b.n THEN cur = cur + b.d(i)
        o.d(i) = cur MOD LIMB_BASE
        carry = cur \ LIMB_BASE
    NEXT
    o.d(nn) = carry
    o.n = nn + 1
    o.neg = 0
    big_trim o
END SUB

' o = |a| - |b|, requires |a| >= |b|
SUB mag_sub (o AS Big, a AS Big, b AS Big)
    DIM borrow AS _INTEGER64
    DIM i AS INTEGER
    borrow = 0
    FOR i = 0 TO a.n - 1
        DIM cur AS _INTEGER64
        cur = a.d(i) - borrow
        IF i < b.n THEN cur = cur - b.d(i)
        IF cur < 0 THEN
            cur = cur + LIMB_BASE
            borrow = 1
        ELSE
            borrow = 0
        END IF
        o.d(i) = cur
    NEXT
    o.n = a.n
    o.neg = 0
    big_trim o
END SUB

' o = a + b, signed
SUB add_big (o AS Big, a AS Big, b AS Big)
    IF a.neg = b.neg THEN
        mag_add o, a, b
        o.neg = a.neg
        big_trim o
        EXIT SUB
    END IF
    DIM c AS INTEGER
    c = mag_cmp%(a, b)
    IF c = 0 THEN
        o.n = 1
        o.d(0) = 0
        o.neg = 0
        EXIT SUB
    END IF
    IF c > 0 THEN
        mag_sub o, a, b
        o.neg = a.neg
    ELSE
        mag_sub o, b, a
        o.neg = b.neg
    END IF
    big_trim o
END SUB

' o = a - b, signed
SUB sub_big (o AS Big, a AS Big, b AS Big)
    DIM nb AS Big
    copy_big nb, b
    IF nb.n > 1 _ORELSE nb.d(0) <> 0 THEN nb.neg = 1 - nb.neg
    add_big o, a, nb
END SUB

' o = a * m, m >= 0, sign preserved
SUB mul_small (o AS Big, a AS Big, m AS _INTEGER64)
    IF m = 0 _ORELSE (a.n = 1 _ANDALSO a.d(0) = 0) THEN
        o.n = 1
        o.d(0) = 0
        o.neg = 0
        EXIT SUB
    END IF
    DIM carry AS _INTEGER64
    DIM i AS INTEGER
    carry = 0
    FOR i = 0 TO a.n - 1
        DIM cur AS _INTEGER64
        cur = a.d(i) * m + carry
        o.d(i) = cur MOD LIMB_BASE
        carry = cur \ LIMB_BASE
    NEXT
    o.d(a.n) = carry
    o.n = a.n + 1
    o.neg = a.neg
    big_trim o
END SUB

' floor(a / b) for a >= 0, b > 0, with the true quotient known to be <= hi.
' Binary search over [0, hi] on |b|*est against |a|: no big-by-big division needed.
FUNCTION div_quot&& (a AS Big, b AS Big, hi AS _INTEGER64)
    IF a.n < b.n THEN
        div_quot = 0
        EXIT FUNCTION
    END IF
    DIM lo AS _INTEGER64, high AS _INTEGER64, md AS _INTEGER64
    lo = 0
    high = hi
    DO WHILE lo < high
        md = lo + (high - lo + 1) \ 2
        mul_small probe, b, md
        IF mag_cmp%(probe, a) <= 0 THEN
            lo = md
        ELSE
            high = md - 1
        END IF
    LOOP
    div_quot = lo
END FUNCTION

SUB emit_time (msv AS DOUBLE)
    DIM ti AS _INTEGER64
    ti = INT(msv * 1000 + .5)
    DIM s AS STRING
    s = LTRIM$(STR$(ti))
    IF LEN(s) < 4 THEN s = STRING$(4 - LEN(s), "0") + s
    s = "TIME_MS=" + LEFT$(s, LEN(s) - 3) + "." + RIGHT$(s, 3) + CHR$(10)
    DIM fs AS STRING * 64
    fs = s
    DIM h AS _OFFSET
    h = GetStdHandle(-12)
    DIM nw AS LONG
    DIM rr AS _OFFSET
    rr = WriteFile(h, _OFFSET(fs), LEN(s), _OFFSET(nw), 0)
END SUB

SUB say (txt AS STRING)
    DIM s AS STRING
    s = txt + CHR$(10)
    DIM fs AS STRING * 512
    fs = s
    DIM h AS _OFFSET
    h = GetStdHandle(-11)
    DIM nw AS LONG
    DIM rr AS _OFFSET
    rr = WriteFile(h, _OFFSET(fs), LEN(s), _OFFSET(nw), 0)
END SUB
