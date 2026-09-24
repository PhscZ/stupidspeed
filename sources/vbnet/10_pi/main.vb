' task 10 pi — expected output: 44889
' build: dotnet build -c Release    run: dotnet bin/Release/net8.0/main.dll
' Gibbons' unbounded spigot on System.Numerics.BigInteger. It emits the leading 3 first;
' the first 10000 emitted digits are summed, and the digits themselves are never printed.

Imports System
Imports System.Numerics

Module Program
    Sub Main()
        Dim q As BigInteger = 1
        Dim r As BigInteger = 0
        Dim t As BigInteger = 1
        Dim k As BigInteger = 1
        Dim n As BigInteger = 3
        Dim l As BigInteger = 3

        Dim total As Long = 0
        Dim emitted As Integer = 0

        While emitted < 10000
            If 4 * q + r - t < n * t Then
                total += CLng(n)
                emitted += 1

                Dim q2 As BigInteger = 10 * q
                Dim r2 As BigInteger = 10 * (r - n * t)
                Dim n2 As BigInteger = BigInteger.Divide(10 * (3 * q + r), t) - 10 * n
                q = q2
                r = r2
                n = n2
            Else
                Dim q2 As BigInteger = q * k
                Dim r2 As BigInteger = (2 * q + r) * l
                Dim t2 As BigInteger = t * l
                Dim k2 As BigInteger = k + 1
                Dim n2 As BigInteger = BigInteger.Divide(q * (7 * k + 2) + r * l, t * l)
                Dim l2 As BigInteger = l + 2
                q = q2
                r = r2
                t = t2
                k = k2
                n = n2
                l = l2
            End If
        End While

        Console.WriteLine(total)
    End Sub
End Module
