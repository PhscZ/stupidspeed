// task 06 char_count — expected output: 10000000
// build: coreclr: dotnet build -c Release | nativeaot: dotnet publish -c Release -p:PublishAot=true | mono: mcs -optimize+ main.cs    run: coreclr: dotnet run -c Release (or bin/Release/net8.0/main.exe) | nativeaot: bin/Release/net8.0/publish/main.exe | mono: mono main.exe
using System;

class Program
{
    static void Main()
    {
        // Build the 100 MB text once, by repeating the whole 10-character block 10000000 times.
        string block = "abcdefghij";
        System.Text.StringBuilder builder = new System.Text.StringBuilder(100000000);
        for (int i = 0; i < 10000000; i++)
        {
            builder.Append(block);
        }
        string text = builder.ToString();

        long count = 0;
        for (int i = 0; i < text.Length; i++)
        {
            char ch = text[i];
            if (ch == 'h')
            {
                count++;
            }
        }
        Console.WriteLine(count);
    }
}
