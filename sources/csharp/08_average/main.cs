// task 08 average — expected output: 0.498046875
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ main.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/main.exe) | nativeaot: bin/Release/net8.0/publish/main.exe | mono: mono main.exe
using System;
using System.Globalization;

class Program
{
    static void Main()
    {
        double total = 0.0;
        for (int i = 0; i < 100000000; i++)
        {
            double reading = (i % 256) / 256.0;
            total += reading;
        }
        double average = total / 100000000;
        Console.WriteLine(average.ToString("R", CultureInfo.InvariantCulture));
    }
}
