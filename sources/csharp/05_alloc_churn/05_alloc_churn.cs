// task 05 alloc_churn — expected output: 1274991808
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ 05_alloc_churn.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/05_alloc_churn.exe) | nativeaot: bin/Release/net8.0/publish/05_alloc_churn.exe | mono: mono 05_alloc_churn.exe
using System;

class Program
{
    static void Main()
    {
        long total = 0;
        byte[][] slots = new byte[256][];
        for (int i = 0; i < 10000000; i++)
        {
            byte[] buf = new byte[64];
            buf[0] = (byte)(i % 256);
            total += buf[0];
            // Storing the buffer keeps it reachable; the array it replaces becomes garbage.
            slots[i % 256] = buf;
        }
        Console.WriteLine(total);
    }
}
