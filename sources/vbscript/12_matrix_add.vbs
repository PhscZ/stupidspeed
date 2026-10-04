' task 12 matrix_add — expected output: 999000000
' build: none (interpreted)    run: cscript //nologo 12_matrix_add.vbs
' note: VBScript has no two-dimensional dynamic array of the shape the spec asks for, so
'       the three matrices are three flat 1000000-element arrays indexed i * n + j, which
'       is the same layout the C row uses. Each element is a 16-byte Variant rather than
'       8 bytes, so the three matrices are 48 MB instead of 24 MB.
' note: the running total passes 2147483647 partway through and the engine promotes it to
'       Double; 999000000 is below 2^53, so the sum is exact.
' note: the total is small enough that CStr prints it plainly, but it is printed through
'       DecStr anyway so that every task in this row formats its integers the same way.
Dim n, A(999999), B(999999), C(999999), i, j, k, total

n = 1000

For i = 0 To n - 1
    For j = 0 To n - 1
        A(i * n + j) = i + j
        B(i * n + j) = i - j
    Next
Next

For i = 0 To n - 1
    For j = 0 To n - 1
        C(i * n + j) = A(i * n + j) + B(i * n + j)
    Next
Next

total = 0
For k = 0 To 999999
    total = total + C(k)
Next

ssReport
WScript.Echo DecStr(total)

' Exact decimal digits for an integral number below 2^53. Splitting off 1e6 at a time
' keeps every intermediate below 2^53, so p * 1000000 is exact; the guard corrects the
' one-off error the division can make at that size.

' timing: Timer() is VBScript's seconds-since-midnight clock with centisecond resolution, so
'         TIME_MS has 16 ms granularity; it goes to stderr and stdout is unchanged.
Dim ssT0
Sub ssReport()
    WScript.StdErr.WriteLine "TIME_MS=" & CLng(Round((Timer() - ssT0) * 1000))
End Sub
ssT0 = Timer()
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
