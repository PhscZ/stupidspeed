' task 08 average — expected output: 0.498046875
' build: dotnet build -c Release 08_average.vbproj    run: dotnet bin/Release/net8.0/08_average.dll
' "R" prints the shortest round-tripping decimal, culture independent and without an exponent.

Imports System
Imports System.Globalization

Module Program
    Sub Main()
        Dim total As Double = 0.0

        For i As Long = 0 To 99999999
            Dim reading As Double = CDbl(i Mod 256) / 256.0
            total += reading
        Next

        Console.WriteLine((total / 100000000.0).ToString("R", CultureInfo.InvariantCulture))
    End Sub
End Module
