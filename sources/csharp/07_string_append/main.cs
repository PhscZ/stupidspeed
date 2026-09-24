// task 07 string_append — expected output: 1000000
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ main.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/main.exe) | nativeaot: bin/Release/net8.0/publish/main.exe | mono: mono main.exe
using System;

class Program
{
    static void Main()
    {
        // Plain string concatenation: System.String is immutable, so this copies every time.
        string text = "";
        for (int i = 0; i < 1000000; i++)
        {
            text = text + "x";
        }
        Console.WriteLine(text.Length);
    }
}
