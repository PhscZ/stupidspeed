' task 15 file_write — expected output: 419430400
' build: dotnet build -c Release 15_file_write.vbproj    run: dotnet bin/Release/net8.0/15_file_write.dll
' The 1 MiB buffer is the byte values 0..255 repeated 4096 times, built once and written
' 50 times per pass, 8 passes over out.bin (recreated at offset 0 each pass), with a
' flush (Flush(True), i.e. FlushFileBuffers) per pass.

Imports System
Imports System.IO

Module Program
    Sub Main()
        Dim sw As System.Diagnostics.Stopwatch = System.Diagnostics.Stopwatch.StartNew()
        Dim buffer(1048575) As Byte
        For i As Integer = 0 To buffer.Length - 1
            buffer(i) = CByte(i Mod 256)
        Next

        Dim written As Long = 0

        For pass As Integer = 1 To 8
            Using stream As New FileStream("out.bin", FileMode.Create, FileAccess.Write)
                For rep As Integer = 1 To 50
                    stream.Write(buffer, 0, buffer.Length)
                    written += buffer.Length
                Next
                stream.Flush(True)
            End Using
        Next

        sw.Stop()
        Console.Error.WriteLine("TIME_MS=" & sw.Elapsed.TotalMilliseconds.ToString("F3", System.Globalization.CultureInfo.InvariantCulture))
        Console.WriteLine(written)
    End Sub
End Module
