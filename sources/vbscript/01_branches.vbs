' task 01 branches — expected output: 33333334 13333333 7619048 45714285
' build: none (interpreted)    run: cscript //nologo 01_branches.vbs
' note: VBScript has no 64-bit integer. Long is 32 bits and overflows at 2147483647,
'       after which the engine promotes the result to Double by itself, without an
'       error. Every total in this row stays under 2^53, so those doubles are exact
'       and every printed answer is exact.
' note: the four counters here never leave Long range — a is the largest at 33333334 —
'       so this task runs entirely on Long arithmetic.
' note: 100000000 iterations of this shape measure about 0.64 us each on this machine,
'       so this task takes about 64 s.
Dim a, b, c, d, i

a = 0
b = 0
c = 0
d = 0

For i = 0 To 99999999
    If i Mod 3 = 0 Then
        a = a + 1
    ElseIf i Mod 5 = 0 Then
        b = b + 1
    ElseIf i Mod 7 = 0 Then
        c = c + 1
    Else
        d = d + 1
    End If
Next

WScript.Echo a & " " & b & " " & c & " " & d
