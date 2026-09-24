' task 15 file_write — expected output: 104857600
' build: dotnet build -c Release    run: dotnet bin/Release/net8.0/main.dll
' The 1 MiB buffer is the byte values 0..255 repeated 4096 times, written 100 times.

Imports System
Imports System.IO

Module Program
    Sub Main()
        Dim buffer(1048575) As Byte
        For i As Integer = 0 To buffer.Length - 1
            buffer(i) = CByte(i Mod 256)
        Next

        Dim written As Long = 0

        Using stream As New FileStream("out.bin", FileMode.Create, FileAccess.Write)
            For pass As Integer = 1 To 100
                stream.Write(buffer, 0, buffer.Length)
                written += buffer.Length
            Next
            stream.Flush(True)
        End Using

        Console.WriteLine(written)
    End Sub
End Module
