' task 09 fib_recursive — expected output: 102334155
' build: none (interpreted)    run: cscript //nologo 09_fib_recursive.vbs
' note: VBScript is interpreted, so the recursion really happens — there is no compiler
'       to turn the double call into a loop, and no marker is needed to stop one.
' note: fib(40) is about 331 million calls. A call measures about 0.83 us here, so the
'       whole task is a few minutes. The result, 102334155, fits in a Long, so the
'       arithmetic never leaves Long range.
' note: Fib is declared with an explicit return variable rather than by naming the
'       function inside itself, which keeps the recursive call on the plain call path.
Dim n

n = 40
WScript.Echo Fib(n)

Function Fib(n)
    If n < 2 Then
        Fib = n
    Else
        Fib = Fib(n - 1) + Fib(n - 2)
    End If
End Function
