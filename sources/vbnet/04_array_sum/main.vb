' task 04 array_sum — expected output: 499999500000
' build: dotnet build -c Release    run: dotnet bin/Release/net8.0/main.dll

Imports System

Module Program
    Sub Main()
        Dim array(999999) As Long

        For i As Long = 0 To 999999
            array(i) = i
        Next

        Dim total As Long = 0
        For i As Long = 0 To 999999
            total += array(i)
        Next

        Console.WriteLine(total)
    End Sub
End Module
