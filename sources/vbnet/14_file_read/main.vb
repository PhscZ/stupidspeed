' task 14 file_read — expected output: 484442112
' build: dotnet build -c Release    run: dotnet bin/Release/net8.0/main.dll
' data.bin is 104857600 bytes, the byte values 0..255 repeating, read 1 MiB at a time.

Imports System
Imports System.IO

Module Program
    Sub Main()
        Dim buffer(1048575) As Byte
        Dim total As Long = 0

        Using stream As New FileStream("data.bin", FileMode.Open, FileAccess.Read)
            Dim count As Integer
            Do
                count = stream.Read(buffer, 0, buffer.Length)
                If count <= 0 Then Exit Do
                For i As Integer = 0 To count - 1
                    total += buffer(i)
                Next
            Loop
        End Using

        Console.WriteLine(total Mod 4294967296L)
    End Sub
End Module
