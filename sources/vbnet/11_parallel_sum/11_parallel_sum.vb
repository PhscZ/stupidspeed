' task 11 parallel_sum — expected output: 7500000075000000
' build: dotnet build -c Release 11_parallel_sum.vbproj    run: dotnet bin/Release/net8.0/11_parallel_sum.dll

Imports System
Imports System.Threading

Module Program
    Sub Main()
        Dim results(3) As Long
        Dim threads(3) As Thread

        For t As Integer = 0 To 3
            Dim idx As Integer = t
            Dim entry As ThreadStart = Sub()
                                           results(idx) = Work(idx)
                                       End Sub
            threads(idx) = New Thread(entry)
            threads(idx).Start()
        Next

        For t As Integer = 0 To 3
            threads(t).Join()
        Next

        Dim total As Long = 0
        For t As Integer = 0 To 3
            total += results(t)
        Next

        Console.WriteLine(total)
    End Sub

    Function Work(t As Integer) As Long
        Dim first As Long = CLng(t) * 25000000L
        Dim last As Long = first + 25000000L - 1
        Dim acc As Long = 0

        For i As Long = first To last
            Select Case i Mod 4
                Case 0
                    acc += 1
                Case 1
                    acc += i
                Case 2
                    acc += 2 * i
                Case 3
                    acc += 3 * i
            End Select
        Next

        Return acc
    End Function
End Module
