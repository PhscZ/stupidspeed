// task 15 file_write — expected output: 104857600
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ main.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/main.exe) | nativeaot: bin/Release/net8.0/publish/main.exe | mono: mono main.exe
using System;
using System.IO;

class Program
{
    static void Main()
    {
        const int ChunkSize = 1048576;
        byte[] buffer = new byte[ChunkSize];
        for (int i = 0; i < buffer.Length; i++)
        {
            buffer[i] = (byte)(i % 256);
        }

        long written = 0;
        using (FileStream fs = new FileStream("out.bin", FileMode.Create, FileAccess.Write))
        {
            for (int pass = 0; pass < 100; pass++)
            {
                fs.Write(buffer, 0, buffer.Length);
                written += buffer.Length;
            }
            fs.Flush(true);
        }
        Console.WriteLine(written);
    }
}
