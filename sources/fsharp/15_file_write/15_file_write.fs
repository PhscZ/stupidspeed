// task 15 file_write — expected output: 419430400
// build: dotnet build -c Release 15_file_write.fsproj    run: dotnet run -c Release (or bin/Release/net8.0/15_file_write.dll)

open System.IO

let sw = System.Diagnostics.Stopwatch.StartNew()

// One megabyte: the bytes 0..255 repeated 4096 times.
let chunk = 1024 * 1024
let buffer : byte[] = Array.zeroCreate chunk
for i in 0 .. chunk - 1 do
    buffer.[i] <- byte (i % 256)

let stream = new FileStream("out.bin", FileMode.Create, FileAccess.Write, FileShare.None)

let mutable written = 0L
// Eight passes, each rewriting the file from offset 0 with a flush to disk.
for _ in 1 .. 8 do
    stream.Seek(0L, SeekOrigin.Begin) |> ignore
    for _ in 1 .. 50 do
        stream.Write(buffer, 0, chunk)
        written <- written + int64 chunk
    stream.Flush(true)
stream.Dispose()

sw.Stop()
System.Console.Error.WriteLine("TIME_MS=" + (sw.Elapsed.TotalMilliseconds.ToString("F3", System.Globalization.CultureInfo.InvariantCulture)))
printfn "%d" written
