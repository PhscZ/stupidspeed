// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ main.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/main.exe) | nativeaot: bin/Release/net8.0/publish/main.exe | mono: mono main.exe
using System;

class Program
{
    static void Main()
    {
        long a = 0, b = 0, c = 0, d = 0;
        for (int i = 0; i < 100000000; i++)
        {
            if (i % 3 == 0)
            {
                a++;
            }
            else if (i % 5 == 0)
            {
                b++;
            }
            else if (i % 7 == 0)
            {
                c++;
            }
            else
            {
                d++;
            }
        }
        Console.WriteLine(a + " " + b + " " + c + " " + d);
    }
}
