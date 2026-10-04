' task 02 switch_case — expected output: 7500000075000000
' build: none (interpreted)    run: cscript //nologo 02_switch_case.vbs
' note: VBScript's switch is Select Case; it compiles to the same chain of comparisons
'       the C row's switch does, because the engine has no jump table.
' note: acc passes 2147483647 about 46000 iterations in, and the engine then promotes
'       it to Double on its own. The final total, 7500000075000000, is under 2^53, so
'       every partial sum is exact and the printed value is the exact answer.
' note: CStr switches to scientific notation at about 1e15 and this engine's locale
'       uses a comma for the decimal separator, so the value is printed through
'       DecStr, which assembles the digits by hand from 1e6-sized chunks.
Dim acc, i

acc = 0

For i = 0 To 99999999
    Select Case i Mod 4
        Case 0
            acc = acc + 1
        Case 1
            acc = acc + i
        Case 2
            acc = acc + 2 * i
        Case 3
            acc = acc + 3 * i
    End Select
Next

ssReport
WScript.Echo DecStr(acc)

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
