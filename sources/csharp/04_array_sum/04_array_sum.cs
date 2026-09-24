// task 04 array_sum — expected output: 499999500000
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ 04_array_sum.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/04_array_sum.exe) | nativeaot: bin/Release/net8.0/publish/04_array_sum.exe | mono: mono 04_array_sum.exe
using System;

class Program
{
    static void Main()
    {
        int n = 1000000;
        long[] array = new long[n];
        for (int i = 0; i < n; i++)
        {
            array[i] = i;
        }

        long total = 0;
        for (int i = 0; i < n; i++)
        {
            total += array[i];
        }
        Console.WriteLine(total);
    }
}
