' task 06 char_count — expected output: 10000000
' build: none (interpreted)    run: cscript //nologo 06_char_count.vbs
' note: VBScript has no character type, so the scan is Mid(text, i, 1) = "h" per character,
'       which allocates a one-character string each time. That is the measured cost:
'       0.33 us per character, so the hundred million characters take about 35 s. There
'       is no cheaper standard-library idiom that still looks at every character —
'       InStr would search rather than scan, and Split(text, "") returns one element.
' note: the C row only counts 'h' — 'a' and 'e' are skipped — so this does the same.
' note: the text is built by doubling "abcdefghij" 20 times to 10485760 characters,
'       truncating that to the 10000000 characters the pattern repeats into, and then
'       expanding the block ten times in a single Replace call. Replace over a
'       ten-million-character source is quadratic in this engine (11 s for a ten-million
'       character result), so the source is kept ten characters long.

' timing: Timer() is VBScript's seconds-since-midnight clock with centisecond resolution, so
'         TIME_MS has 16 ms granularity; it goes to stderr and stdout is unchanged.
Dim ssT0
Sub ssReport()
    WScript.StdErr.WriteLine "TIME_MS=" & CLng(Round((Timer() - ssT0) * 1000))
End Sub
Dim block, text, i, n, count

ssT0 = Timer()
block = "abcdefghij"
For i = 1 To 20
    block = block & block
Next
block = Left(block, 10000000)
text = Replace(Space(10), " ", block)

n = Len(text)
count = 0
For i = 1 To n
    If Mid(text, i, 1) = "h" Then
        count = count + 1
    End If
Next

ssReport
WScript.Echo count
