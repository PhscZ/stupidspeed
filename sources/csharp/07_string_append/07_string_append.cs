// task 07 string_append — expected output: 1000000
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ 07_string_append.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/07_string_append.exe) | nativeaot: bin/Release/net8.0/publish/07_string_append.exe | mono: mono 07_string_append.exe
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
