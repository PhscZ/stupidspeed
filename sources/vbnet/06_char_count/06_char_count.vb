' task 06 char_count — expected output: 10000000
' build: dotnet build -c Release 06_char_count.vbproj    run: dotnet bin/Release/net8.0/06_char_count.dll
' The 100 MB text is built once, by repeating the whole ten character block, before the scan.

Imports System
Imports System.Collections.Generic
Imports System.Linq

Module Program
    Sub Main()
        Dim block As String = "abcdefghij"
        Dim parts As IEnumerable(Of String) = Enumerable.Repeat(block, 10000000)
        Dim text As String = String.Concat(parts)

        Dim count As Long = 0
        For i As Integer = 0 To text.Length - 1
            If text(i) = "h"c Then
                count += 1
            End If
        Next

        Console.WriteLine(count)
    End Sub
End Module
