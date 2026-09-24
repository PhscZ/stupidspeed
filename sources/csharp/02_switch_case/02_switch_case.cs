// task 02 switch_case — expected output: 7500000075000000
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ 02_switch_case.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/02_switch_case.exe) | nativeaot: bin/Release/net8.0/publish/02_switch_case.exe | mono: mono 02_switch_case.exe
using System;

class Program
{
    static void Main()
    {
        long acc = 0;
        for (int i = 0; i < 100000000; i++)
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
        Console.WriteLine(acc);
    }
}
