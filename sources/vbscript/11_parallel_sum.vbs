' task 11 parallel_sum — expected output: 7500000075000000
' build: none (interpreted)    run: cscript //nologo 11_parallel_sum.vbs
' note: VBScript has no threads and no shared memory between processes, so this is four
'       child processes rather than four threads. The parent starts four copies of this
'       same file with WScript.Shell.Exec, each one given a worker index as an argument,
'       and each child computes one quarter of task 02's range and prints its partial
'       sum. Reading a child's StdOut blocks until that child closes it, which is the
'       join, and the parent adds the four partials.
' note: this is the same mechanism the R row uses (PSOCK workers) and the COBOL row uses
'       (CBL_GC_FORK): the benchmark accepts it as "pass, but with processes rather than
'       threads", and unlike the R and COBOL rows it is real parallelism on Windows.
' note: each worker owns a fixed quarter, so which one finishes first cannot change the
'       answer. The parent prints through DecStr because the total, 7500000075000000,
'       is above 2^31 and CStr would use scientific notation for it.
' note: the child inherits nothing but its argument; the script's own full path is passed
'       to it, so the parent can be started from any working directory.
Dim shell, kids(3), i, t, total, cmd

If WScript.Arguments.Count = 1 Then
    ' child: compute one quarter and print it
    WScript.Echo DecStr(WorkRange(CLng(WScript.Arguments(0))))
    WScript.Quit 0
End If

Set shell = CreateObject("WScript.Shell")

For t = 0 To 3
    cmd = "cscript.exe //nologo """ & WScript.ScriptFullName & """ " & CStr(t)
    Set kids(t) = shell.Exec(cmd)
Next

total = 0.0
For t = 0 To 3
    total = total + CDbl(Trim(kids(t).StdOut.ReadAll()))
Next

ssReport
WScript.Echo DecStr(total)

Function WorkRange(t)
    Dim acc, i, lo, hi

    acc = 0
    lo = t * 25000000.0
    hi = lo + 25000000.0
    For i = lo To hi - 1
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
    WorkRange = acc
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
