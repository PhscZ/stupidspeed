// task 08 average — expected output: 0.498046875
// build: dotnet build -c Release 08_average.fsproj    run: dotnet run -c Release (or bin/Release/net8.0/08_average.dll)

let sw = System.Diagnostics.Stopwatch.StartNew()

let mutable total = 0.0

let mutable i = 0
while i < 100000000 do
    let reading = float (i % 256) / 256.0
    total <- total + reading
    i <- i + 1

let average = total / 100000000.0
sw.Stop()
System.Console.Error.WriteLine("TIME_MS=" + (sw.Elapsed.TotalMilliseconds.ToString("F3", System.Globalization.CultureInfo.InvariantCulture)))
printfn "%s" (average.ToString("R", System.Globalization.CultureInfo.InvariantCulture))
