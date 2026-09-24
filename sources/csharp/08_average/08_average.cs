// task 08 average — expected output: 0.498046875
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ 08_average.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/08_average.exe) | nativeaot: bin/Release/net8.0/publish/08_average.exe | mono: mono 08_average.exe
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
