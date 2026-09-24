' task 03 func_sum — expected output: 100000000
' build: dotnet build -c Release    run: dotnet bin/Release/net8.0/main.dll
' MethodImplOptions.NoInlining keeps the JIT from folding the call away.

Imports System
Imports System.Runtime.CompilerServices

Module Program
    <MethodImpl(MethodImplOptions.NoInlining)>
    Function AddOne(n As Long) As Long
        Return n + 1
    End Function

    Sub Main()
        Dim value As Long = 0

        For i As Long = 1 To 100000000
            value = AddOne(value)
        Next

        Console.WriteLine(value)
    End Sub
End Module
