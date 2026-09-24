' task 01 branches — expected output: 33333334 13333333 7619048 45714285
' build: dotnet build -c Release 01_branches.vbproj    run: dotnet bin/Release/net8.0/01_branches.dll

Imports System

Module Program
    Sub Main()
        Dim a As Long = 0
        Dim b As Long = 0
        Dim c As Long = 0
        Dim d As Long = 0

        For i As Long = 0 To 99999999
            If i Mod 3 = 0 Then
                a += 1
            ElseIf i Mod 5 = 0 Then
                b += 1
            ElseIf i Mod 7 = 0 Then
                c += 1
            Else
                d += 1
            End If
        Next

        Console.WriteLine(a & " " & b & " " & c & " " & d)
    End Sub
End Module
