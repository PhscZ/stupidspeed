' task 03 func_sum — expected output: 100000000
' build: none (interpreted)    run: cscript //nologo 03_func_sum.vbs
' note: VBScript is interpreted and has no inlining, so the call really happens a
'       hundred million times and no marker is needed; the function does not have to
'       live in a separate file, because there is no compiler that could delete it.
' note: a call measures about 0.83 us on this machine, so this task takes about 83 s.
' note: value stays inside Long range the whole way (it ends at 100000000), so this is
'       Long arithmetic from start to finish.

' timing: Timer() is VBScript's seconds-since-midnight clock with centisecond resolution, so
'         TIME_MS has 16 ms granularity; it goes to stderr and stdout is unchanged.
Dim ssT0
Sub ssReport()
    WScript.StdErr.WriteLine "TIME_MS=" & CLng(Round((Timer() - ssT0) * 1000))
End Sub
Dim value, i

ssT0 = Timer()
value = 0

For i = 1 To 100000000
    value = AddOne(value)
Next

ssReport
WScript.Echo value

Function AddOne(n)
    AddOne = n + 1
End Function
