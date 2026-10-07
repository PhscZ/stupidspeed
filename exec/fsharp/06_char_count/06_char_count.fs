// task 06 char_count — expected output: 10000000
// build: dotnet build -c Release 06_char_count.fsproj    run: dotnet run -c Release (or bin/Release/net8.0/06_char_count.dll)

let sw = System.Diagnostics.Stopwatch.StartNew()

// The whole 100 MB text is built in one operation, not by appending.
let text = String.replicate 10000000 "abcdefghij"

let mutable count = 0L
let len = text.Length
let mutable i = 0
while i < len do
    let ch = text.[i]
    if ch = 'a' then
        ()
    elif ch = 'e' then
        ()
    elif ch = 'h' then
        count <- count + 1L
    else
        ()
    i <- i + 1

sw.Stop()
System.Console.Error.WriteLine("TIME_MS=" + (sw.Elapsed.TotalMilliseconds.ToString("F3", System.Globalization.CultureInfo.InvariantCulture)))
printfn "%d" count
