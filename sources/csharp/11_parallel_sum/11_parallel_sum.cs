// task 11 parallel_sum — expected output: 7500000075000000
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ 11_parallel_sum.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/11_parallel_sum.exe) | nativeaot: bin/Release/net8.0/publish/11_parallel_sum.exe | mono: mono 11_parallel_sum.exe
using System;
using System.Threading;

class Program
{
    static long Work(int t)
    {
        long start = (long)t * 25000000;
        long end = start + 25000000;
        long acc = 0;
        for (long i = start; i < end; i++)
        {
            switch (i % 4)
            {
                case 0:
                    acc += 1;
                    break;
                case 1:
                    acc += i;
                    break;
                case 2:
                    acc += 2 * i;
                    break;
                case 3:
                    acc += 3 * i;
                    break;
            }
        }
        return acc;
    }

    static void Main()
    {
        long[] results = new long[4];
        Thread[] threads = new Thread[4];
        for (int t = 0; t < 4; t++)
        {
            int id = t;
            threads[t] = new Thread(() => { results[id] = Work(id); });
        }
        for (int t = 0; t < 4; t++)
        {
            threads[t].Start();
        }
        for (int t = 0; t < 4; t++)
        {
            threads[t].Join();
        }

        long total = 0;
        for (int t = 0; t < 4; t++)
        {
            total += results[t];
        }
        Console.WriteLine(total);
    }
}
