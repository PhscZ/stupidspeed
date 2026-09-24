// task 03 func_sum — expected output: 100000000
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ main.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/main.exe) | nativeaot: bin/Release/net8.0/publish/main.exe | mono: mono main.exe
using System;
using System.Runtime.CompilerServices;

class Program
{
    // NoInlining keeps the call real; without it the JIT would fold the whole loop away.
    [MethodImpl(MethodImplOptions.NoInlining)]
    static long AddOne(long n)
    {
        return n + 1;
    }

    static void Main()
    {
        long value = 0;
        for (int i = 0; i < 100000000; i++)
        {
            value = AddOne(value);
        }
        Console.WriteLine(value);
    }
}
