' task 05 alloc_churn — expected output: 1274991808
' build: none (interpreted)    run: cscript //nologo 05_alloc_churn.vbs
' note: VBScript has no malloc and no explicit free. The allocation primitive here is
'       String(64, Chr(i Mod 256)), which allocates a fresh 64-character string every
'       iteration, and Asc(buf) reads the byte the C row writes into buf[0].
' note: storing into slots keeps the buffer reachable and drops the one it replaces,
'       which is what makes the replaced string garbage for the engine's collector —
'       the same thing the C row's free(slots[slot]) does by hand. Without the store
'       the whole loop would be dead code in a language that optimizes.
' note: the total, 1274991808, stays inside Long range, so this is Long arithmetic.

' timing: Timer() is VBScript's seconds-since-midnight clock with centisecond resolution, so
'         TIME_MS has 16 ms granularity; it goes to stderr and stdout is unchanged.
Dim ssT0
Sub ssReport()
    WScript.StdErr.WriteLine "TIME_MS=" & CLng(Round((Timer() - ssT0) * 1000))
End Sub
Dim slots(255), total, i, buf, slot

ssT0 = Timer()
total = 0

For i = 0 To 9999999
    buf = String(64, Chr(i Mod 256))
    total = total + Asc(buf)
    slot = i Mod 256
    slots(slot) = buf
Next

ssReport
WScript.Echo total
