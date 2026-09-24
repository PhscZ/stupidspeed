// task 13 matrix_mul — expected output: 599995000
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ main.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/main.exe) | nativeaot: bin/Release/net8.0/publish/main.exe | mono: mono main.exe
using System;

class Program
{
    static void Main()
    {
        int n = 500;
        long[] a = new long[n * n];
        long[] b = new long[n * n];
        long[] c = new long[n * n];

        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
            {
                a[i * n + j] = (i + j) % 7;
                b[i * n + j] = (i * j) % 5;
            }
        }

        // Plain i, j, k triple loop; the loop order is part of the task.
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
            {
                long sum = 0;
                for (int k = 0; k < n; k++)
                {
                    sum += a[i * n + k] * b[k * n + j];
                }
                c[i * n + j] = sum;
            }
        }

        long total = 0;
        for (int idx = 0; idx < n * n; idx++)
        {
            total += c[idx];
        }
        Console.WriteLine(total);
    }
}
