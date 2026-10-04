// task 03 func_sum — expected output: 100000000
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ 03_func_sum.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/03_func_sum.exe) | nativeaot: bin/Release/net8.0/publish/03_func_sum.exe | mono: mono 03_func_sum.exe
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
        System.Diagnostics.Stopwatch sw = System.Diagnostics.Stopwatch.StartNew();
        long value = 0;
        for (int i = 0; i < 100000000; i++)
        {
            value = AddOne(value);
        }
        sw.Stop();
        Console.Error.WriteLine("TIME_MS=" + sw.Elapsed.TotalMilliseconds.ToString("F3", System.Globalization.CultureInfo.InvariantCulture));
        Console.WriteLine(value);
    }
}
