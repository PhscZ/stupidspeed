' task 13 matrix_mul — expected output: 599995000
' build: none (interpreted)    run: cscript //nologo 13_matrix_mul.vbs
' note: the matrices are flat 250000-element arrays indexed i * n + j, the same layout
'       the C row uses; VBScript has no two-dimensional dynamic array that can be sized
'       at run time, and the flat form is what the C reference does anyway.
' note: the loop order is the plain i, j, k the spec asks for, so B is walked down a
'       column at a time. Reordering it would be faster and that is the point of the task,
'       so it is left alone.
' note: each element of C is a sum of 500 terms each at most 6 * 4 = 24, so it fits in a
'       Long; the grand total, 599995000, does too.

' timing: Timer() is VBScript's seconds-since-midnight clock with centisecond resolution, so
'         TIME_MS has 16 ms granularity; it goes to stderr and stdout is unchanged.
Dim ssT0
Sub ssReport()
    WScript.StdErr.WriteLine "TIME_MS=" & CLng(Round((Timer() - ssT0) * 1000))
End Sub
Dim n, A(249999), B(249999), C(249999), i, j, k, sum, total

ssT0 = Timer()
n = 500

For i = 0 To n - 1
    For j = 0 To n - 1
        A(i * n + j) = (i + j) Mod 7
        B(i * n + j) = (i * j) Mod 5
    Next
Next

For i = 0 To n - 1
    For j = 0 To n - 1
        sum = 0
        For k = 0 To n - 1
            sum = sum + A(i * n + k) * B(k * n + j)
        Next
        C(i * n + j) = sum
    Next
Next

total = 0
For k = 0 To 249999
    total = total + C(k)
Next

ssReport
WScript.Echo total
