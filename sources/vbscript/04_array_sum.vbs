' task 04 array_sum — expected output: 499999500000
' build: none (interpreted)    run: cscript //nologo 04_array_sum.vbs
' note: the array is a plain 1000000-element VBScript array of Variants, which is the
'       only array the engine has; the C row's int64 array is 8 MB, this one is 16 MB,
'       because a Variant is 16 bytes. It is still one contiguous block walked in order.
' note: the total passes 2147483647 about 65536 elements in and the engine promotes it
'       to Double; 499999500000 is under 2^53, so the sum is exact, and it is printed
'       through DecStr because CStr would use scientific notation above about 1e15.
Dim arr(999999), i, total

For i = 0 To 999999
    arr(i) = i
Next

total = 0
For i = 0 To 999999
    total = total + arr(i)
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
