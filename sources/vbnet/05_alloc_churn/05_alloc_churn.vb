' task 05 alloc_churn — expected output: 1274991808
' build: dotnet build -c Release 05_alloc_churn.vbproj    run: dotnet bin/Release/net8.0/05_alloc_churn.dll

Imports System

Module Program
    Sub Main()
        Dim sw As System.Diagnostics.Stopwatch = System.Diagnostics.Stopwatch.StartNew()
        Dim total As Long = 0
        Dim slots(255)() As Byte

        For i As Long = 0 To 9999999
            Dim buf(63) As Byte
            buf(0) = CByte(i Mod 256)
            total += buf(0)
            slots(CInt(i Mod 256)) = buf
        Next

        sw.Stop()
        Console.Error.WriteLine("TIME_MS=" & sw.Elapsed.TotalMilliseconds.ToString("F3", System.Globalization.CultureInfo.InvariantCulture))
        Console.WriteLine(total)
    End Sub
End Module
