// task 07 string_append — expected output: 250000
// build: dotnet build -c Release 07_string_append.fsproj    run: dotnet run -c Release (or bin/Release/net8.0/07_string_append.dll)

let sw = System.Diagnostics.Stopwatch.StartNew()

// System.String is immutable, so every + copies the whole string.
let mutable text = ""
let mutable i = 0
while i < 250000 do
    text <- text + "x"
    i <- i + 1

sw.Stop()
System.Console.Error.WriteLine("TIME_MS=" + (sw.Elapsed.TotalMilliseconds.ToString("F3", System.Globalization.CultureInfo.InvariantCulture)))
printfn "%d" text.Length
