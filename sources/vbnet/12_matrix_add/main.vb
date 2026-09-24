' task 12 matrix_add — expected output: 999000000
' build: dotnet build -c Release    run: dotnet bin/Release/net8.0/main.dll

Imports System

Module Program
    Sub Main()
        Const n As Integer = 1000
        Dim a(n * n - 1) As Long
        Dim b(n * n - 1) As Long
        Dim c(n * n - 1) As Long

        For i As Integer = 0 To n - 1
            For j As Integer = 0 To n - 1
                a(i * n + j) = i + j
                b(i * n + j) = i - j
            Next
        Next

        For i As Integer = 0 To n - 1
            For j As Integer = 0 To n - 1
                c(i * n + j) = a(i * n + j) + b(i * n + j)
            Next
        Next

        Dim total As Long = 0
        For i As Integer = 0 To n - 1
            For j As Integer = 0 To n - 1
                total += c(i * n + j)
            Next
        Next

        Console.WriteLine(total)
    End Sub
End Module
