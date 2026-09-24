// task 14 file_read — expected output: 484442112
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ main.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/main.exe) | nativeaot: bin/Release/net8.0/publish/main.exe | mono: mono main.exe
using System;
using System.IO;

class Program
{
    static void Main()
    {
        const int ChunkSize = 1048576;
        byte[] buffer = new byte[ChunkSize];
        long total = 0;
        using (FileStream fs = new FileStream("data.bin", FileMode.Open, FileAccess.Read))
        {
            int read;
            while ((read = fs.Read(buffer, 0, buffer.Length)) > 0)
            {
                for (int i = 0; i < read; i++)
                {
                    total += buffer[i];
                }
            }
        }
        Console.WriteLine(total % 4294967296L);
    }
}
