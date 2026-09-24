' task 02 switch_case — expected output: 7500000075000000
' build: dotnet build -c Release 02_switch_case.vbproj    run: dotnet bin/Release/net8.0/02_switch_case.dll

Imports System

Module Program
    Sub Main()
        Dim acc As Long = 0

        For i As Long = 0 To 99999999
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

        Console.WriteLine(acc)
    End Sub
End Module
