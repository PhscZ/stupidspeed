' task 09 fib_recursive — expected output: 102334155
' build: dotnet build -c Release 09_fib_recursive.vbproj    run: dotnet bin/Release/net8.0/09_fib_recursive.dll

Imports System

Module Program
    Function Fib(n As Long) As Long
        If n < 2 Then Return n
        Return Fib(n - 1) + Fib(n - 2)
    End Function

    Sub Main()
        Console.WriteLine(Fib(40))
    End Sub
End Module
