// task 12 matrix_add — expected output: 999000000
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ main.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/main.exe) | nativeaot: bin/Release/net8.0/publish/main.exe | mono: mono main.exe
using System;

class Program
{
    static void Main()
    {
        int n = 1000;
        long[] a = new long[n * n];
        long[] b = new long[n * n];
        long[] c = new long[n * n];

        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
            {
                a[i * n + j] = i + j;
                b[i * n + j] = i - j;
            }
        }

        for (int idx = 0; idx < n * n; idx++)
        {
            c[idx] = a[idx] + b[idx];
        }

        long total = 0;
        for (int idx = 0; idx < n * n; idx++)
        {
            total += c[idx];
        }
        Console.WriteLine(total);
    }
}
