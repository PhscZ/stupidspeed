' task 07 string_append — expected output: 250000
' build: none (interpreted)    run: cscript //nologo 07_string_append.vbs
' note: VBScript strings are immutable and copy on every concatenation, so this loop is
'       quadratic exactly as the spec intends: text = text & "x" builds a fresh string of
'       length i every iteration, copying i characters. There is no StringBuilder in the
'       standard library and no growable string in the engine.
' note: the count is 250000. At 250000 the loop copies about 3.1 * 10^10 characters in
'       total, which is the quadratic cost the task exists to measure.
' note: Len(text) is used as the printed value, so the loop cannot be deleted; an
'       interpreted engine would not delete it anyway.

' timing: Timer() is VBScript's seconds-since-midnight clock with centisecond resolution, so
'         TIME_MS has 16 ms granularity; it goes to stderr and stdout is unchanged.
Dim ssT0
Sub ssReport()
    WScript.StdErr.WriteLine "TIME_MS=" & CLng(Round((Timer() - ssT0) * 1000))
End Sub
Dim text, i

ssT0 = Timer()
text = ""

For i = 1 To 250000
    text = text & "x"
Next

ssReport
WScript.Echo Len(text)
