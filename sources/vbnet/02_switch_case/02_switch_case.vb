' task 02 switch_case — expected output: 7500000075000000
' build: dotnet build -c Release 02_switch_case.vbproj    run: dotnet bin/Release/net8.0/02_switch_case.dll

Imports System

Module Program
    Sub Main()
        Dim sw As System.Diagnostics.Stopwatch = System.Diagnostics.Stopwatch.StartNew()
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

        sw.Stop()
        Console.Error.WriteLine("TIME_MS=" & sw.Elapsed.TotalMilliseconds.ToString("F3", System.Globalization.CultureInfo.InvariantCulture))
        Console.WriteLine(acc)
    End Sub
End Module
