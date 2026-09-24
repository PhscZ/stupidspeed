' task 13 matrix_mul — expected output: 599995000
' build: dotnet build -c Release 13_matrix_mul.vbproj    run: dotnet bin/Release/net8.0/13_matrix_mul.dll

Imports System

Module Program
    Sub Main()
        Const n As Integer = 500
        Dim a(n * n - 1) As Long
        Dim b(n * n - 1) As Long
        Dim c(n * n - 1) As Long

        For i As Integer = 0 To n - 1
            For j As Integer = 0 To n - 1
                a(i * n + j) = (i + j) Mod 7
                b(i * n + j) = (i * j) Mod 5
            Next
        Next

        For i As Integer = 0 To n - 1
            For j As Integer = 0 To n - 1
                Dim sum As Long = 0
                For k As Integer = 0 To n - 1
                    sum += a(i * n + k) * b(k * n + j)
                Next
                c(i * n + j) = sum
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
