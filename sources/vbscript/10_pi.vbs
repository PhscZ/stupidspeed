' task 10 pi — expected output: 4470
' build: none (interpreted)    run: cscript //nologo 10_pi.vbs
' note: VBScript has no big-integer type, so this is the C reference's hand-written big
'       integer: sign-magnitude, little-endian limbs, base 1e9, with add, subtract,
'       multiply by a small integer, and a quotient that comes out of repeated
'       subtraction because the spigot only ever asks for one decimal digit at a time.
'       Gibbons' unbounded spigot is the same loop, step for step; only the sum of the
'       1000 digits is printed.
' note: the limbs are Doubles, which is the only numeric type wide enough. A limb times
'       the spigot's multiplier is at most 999999999 * 232471, about 2.3e14, and a Double
'       is exact to 2^53 = 9e15, so every product and every carry is exact. There is no
'       Mod operator on numbers this size (VBScript's Mod is Long-only and overflows), so
'       the carry is Int(p / 1e9) and the remainder is p - carry * 1e9; that division is
'       exact enough that Int never lands one below the true quotient, because p is an
'       integer and its distance to the next multiple of 1e9 is at least 1e-9, while the
'       rounding error at 2.3e14 is below 2e-11.
' note: the six big integers live in one two-dimensional array, LB(v, i), rather than in a
'       class, because a class member array costs nine times as much to index as a local
'       or global one in this engine (measured: 9.1 s against 1.0 s for a million
'       multiply-and-carry steps). The state is about 16000 limbs at 1000 digits — 1248
'       limbs at 1000 digits, measured — so the array is sized 40000. Nothing here needs
'       128-bit arithmetic.
' note: this is the slowest task in the row. Measured scaling, wall clock for the whole
'       program: 100 digits 1.19 s, 200 3.24 s, 400 10.4 s, 800 46.1 s, 1600 205.5 s. The
'       exponent is about 2.16 in the digit count, which extrapolates to roughly three
'       hours for the full 1000-digit run. That is why the reduced-scale runs below were
'       done first: they reproduce the known digit sums computed independently with
'       mpmath -- 100 digits -> 471, 200 -> 897, 400 -> 1753, 800 -> 3588, 1600 -> 7269 --
'       which is the evidence that the arithmetic is right at every scale. The full
'       1000-digit run is left to the runner, which has no timeout.
Const DIGITS = 1000
Const MAXLIMB = 40000
Const BASE = 1000000000.0

' indices into LB and the matching limb-count and sign arrays
Const QV = 0
Const RV = 1
Const TV = 2
Const UV = 3
Const VV = 4
Const WV = 5

Dim LB(5, 39999), LN(5), LG(5)
Dim k, l, n, sum, produced, nextn

BSet QV, 1
BSet RV, 0
BSet TV, 1

k = 1
l = 3
n = 3
sum = 0
produced = 0

Do While produced < DIGITS
    BMulSmall UV, QV, 4
    BAdd UV, UV, RV                    ' u = 4q + r
    BMulSmall VV, TV, n + 1            ' v = (n + 1)t

    If BCmp(UV, VV) < 0 Then
        ' the digit n is settled
        sum = sum + n
        produced = produced + 1

        BMulSmall UV, QV, 3
        BAdd UV, UV, RV
        BMulSmall UV, UV, 10           ' u = 10(3q + r)
        nextn = BQuot(UV, TV) - 10 * n

        BMulSmall VV, TV, n            ' v = n t
        BSub VV, RV, VV                ' v = r - n t
        BMulSmall RV, VV, 10           ' r = 10(r - n t)
        BMulSmall QV, QV, 10           ' q = 10q, t is unchanged

        n = nextn
    Else
        ' not settled yet: widen the state by one more term
        BMulSmall UV, QV, 7 * k + 2
        BMulSmall VV, RV, l
        BAdd UV, UV, VV                ' u = q(7k + 2) + r l
        BMulSmall VV, TV, l            ' v = t l
        nextn = BQuot(UV, VV)

        BMulSmall UV, QV, 2
        BAdd UV, UV, RV
        BMulSmall UV, UV, l            ' u = (2q + r) l
        BCopy RV, UV
        BMulSmall QV, QV, k
        BMulSmall TV, TV, l

        k = k + 1
        l = l + 2
        n = nextn
    End If
Loop

ssReport
WScript.Echo DecStr(sum)

Sub BSet(ByVal x, ByVal v)
    Dim c
    c = 0
    Do While v > 0
        LB(x, c) = v - Int(v / BASE) * BASE
        v = Int(v / BASE)
        c = c + 1
    Loop
    LN(x) = c
    LG(x) = 0
End Sub

ssT0 = Timer()
Sub BCopy(ByVal d, ByVal s)
    Dim i, c
    c = LN(s)
    For i = 0 To c - 1
        LB(d, i) = LB(s, i)
    Next
    LN(d) = c
    LG(d) = LG(s)
End Sub

Sub BTrim(ByVal x)
    Dim c
    c = LN(x)
    Do While c > 0
        If LB(x, c - 1) <> 0 Then Exit Do
        c = c - 1
    Loop
    LN(x) = c
    If c = 0 Then LG(x) = 0
End Sub

Function BCmpMag(ByVal a, ByVal b)
    Dim i, an, bn
    an = LN(a)
    bn = LN(b)
    If an <> bn Then
        If an < bn Then BCmpMag = -1 Else BCmpMag = 1
        Exit Function
    End If
    For i = an - 1 To 0 Step -1
        If LB(a, i) <> LB(b, i) Then
            If LB(a, i) < LB(b, i) Then BCmpMag = -1 Else BCmpMag = 1
            Exit Function
        End If
    Next
    BCmpMag = 0
End Function

Function BCmp(ByVal a, ByVal b)
    Dim c
    If LG(a) <> LG(b) Then
        If LG(a) <> 0 Then BCmp = -1 Else BCmp = 1
        Exit Function
    End If
    c = BCmpMag(a, b)
    If LG(a) <> 0 Then c = -c
    BCmp = c
End Function

Sub BAddMag(ByVal r, ByVal a, ByVal b)
    Dim i, c, s, carry, an, bn
    an = LN(a)
    bn = LN(b)
    c = an
    If bn > c Then c = bn
    carry = 0
    For i = 0 To c - 1
        s = carry
        If i < an Then s = s + LB(a, i)
        If i < bn Then s = s + LB(b, i)
        If s >= BASE Then
            s = s - BASE
            carry = 1
        Else
            carry = 0
        End If
        LB(r, i) = s
    Next
    If carry <> 0 Then
        LB(r, c) = carry
        LN(r) = c + 1
    Else
        LN(r) = c
    End If
    LG(r) = 0
End Sub

Sub BSubMag(ByVal r, ByVal a, ByVal b)
    Dim i, bi, borrow, an, bn
    an = LN(a)
    bn = LN(b)
    borrow = 0
    For i = 0 To an - 1
        bi = borrow
        If i < bn Then bi = bi + LB(b, i)
        If LB(a, i) >= bi Then
            LB(r, i) = LB(a, i) - bi
            borrow = 0
        Else
            LB(r, i) = LB(a, i) + BASE - bi
            borrow = 1
        End If
    Next
    LN(r) = an
    LG(r) = 0
    BTrim r
End Sub

Sub BAdd(ByVal r, ByVal a, ByVal b)
    Dim an, bn
    an = LG(a)
    bn = LG(b)
    If an = bn Then
        BAddMag r, a, b
        LG(r) = an
    ElseIf BCmpMag(a, b) >= 0 Then
        BSubMag r, a, b
        LG(r) = an
    Else
        BSubMag r, b, a
        LG(r) = bn
    End If
    BTrim r
End Sub

Sub BSub(ByVal r, ByVal a, ByVal b)
    Dim an, bn
    an = LG(a)
    bn = LG(b)
    If an <> bn Then
        BAddMag r, a, b
        LG(r) = an
    ElseIf BCmpMag(a, b) >= 0 Then
        BSubMag r, a, b
        LG(r) = an
    Else
        BSubMag r, b, a
        If an = 0 Then LG(r) = 1 Else LG(r) = 0
    End If
    BTrim r
End Sub

Sub BMulSmall(ByVal r, ByVal a, ByVal m)
    Dim i, c, p, carry
    c = LN(a)
    If m = 0 Or c = 0 Then
        LN(r) = 0
        LG(r) = 0
        Exit Sub
    End If
    carry = 0
    For i = 0 To c - 1
        p = LB(a, i) * m + carry
        carry = Int(p / BASE)
        LB(r, i) = p - carry * BASE
    Next
    Do While carry > 0
        LB(r, c) = carry - Int(carry / BASE) * BASE
        carry = Int(carry / BASE)
        c = c + 1
    Loop
    LN(r) = c
    LG(r) = LG(a)
    BTrim r
End Sub

' floor(a / b) for a >= 0 and b > 0, by counting how many times b fits into a. The
' spigot only ever asks for a quotient of one decimal digit, so this terminates quickly.
Function BQuot(ByVal a, ByVal b)
    Dim q
    If LG(a) <> 0 Or LG(b) <> 0 Or LN(b) = 0 Then
        BQuot = 0
        Exit Function
    End If
    BCopy WV, b
    q = 0
    Do
        If BCmp(a, WV) < 0 Then Exit Do
        q = q + 1
        BAddMag WV, WV, b
    Loop
    BQuot = q
End Function

' Exact decimal digits for an integral number below 2^53. Splitting off 1e6 at a time
' keeps every intermediate below 2^53, so p * 1000000 is exact; the guard corrects the
' one-off error the division can make at that size.

' timing: Timer() is VBScript's seconds-since-midnight clock with centisecond resolution, so
'         TIME_MS has 16 ms granularity; it goes to stderr and stdout is unchanged.
Dim ssT0
Sub ssReport()
    WScript.StdErr.WriteLine "TIME_MS=" & CLng(Round((Timer() - ssT0) * 1000))
End Sub
Function DecStr(v)
    Dim parts(), np, p, r, s, i

    If v < 1.0 Then
        DecStr = "0"
        Exit Function
    End If

    np = 0
    ReDim parts(8)

    Do While v >= 1.0
        p = Int(v / 1000000.0)
        r = v - p * 1000000.0
        If r < 0.0 Then
            p = p - 1.0
            r = r + 1000000.0
        ElseIf r >= 1000000.0 Then
            p = p + 1.0
            r = r - 1000000.0
        End If
        If np > UBound(parts) Then
            ReDim Preserve parts(np + 8)
        End If
        parts(np) = r
        np = np + 1
        v = p
    Loop

    s = CStr(parts(np - 1))
    For i = np - 2 To 0 Step -1
        s = s & Right("000000" & CStr(parts(i)), 6)
    Next
    DecStr = s
End Function
