' task 07 string_append — expected output: 1000000
' build: dotnet build -c Release    run: dotnet bin/Release/net8.0/main.dll
' String concatenation with & copies the whole string every time, as intended.

Imports System

Module Program
    Sub Main()
        Dim text As String = ""

        For i As Long = 1 To 1000000
            text = text & "x"
        Next

        Console.WriteLine(text.Length)
    End Sub
End Module
