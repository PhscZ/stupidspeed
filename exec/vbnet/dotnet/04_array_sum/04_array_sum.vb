' task 04 array_sum — expected output: 499999500000
' build: dotnet build -c Release 04_array_sum.vbproj    run: dotnet bin/Release/net8.0/04_array_sum.dll

Imports System

Module Program
    Sub Main()
        Dim sw As System.Diagnostics.Stopwatch = System.Diagnostics.Stopwatch.StartNew()
        Dim array(999999) As Long

        For i As Long = 0 To 999999
            array(i) = i
        Next

        Dim total As Long = 0
        For i As Long = 0 To 999999
            total += array(i)
        Next

        sw.Stop()
        Console.Error.WriteLine("TIME_MS=" & sw.Elapsed.TotalMilliseconds.ToString("F3", System.Globalization.CultureInfo.InvariantCulture))
        Console.WriteLine(total)
    End Sub
End Module
