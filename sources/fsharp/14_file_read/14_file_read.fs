// task 14 file_read — expected output: 484442112
// build: dotnet build -c Release 14_file_read.fsproj    run: dotnet run -c Release (or bin/Release/net8.0/14_file_read.dll)

open System.IO

// data.bin is the bytes 0..255 repeating, 104857600 bytes, in the working directory.
let chunk = 1024 * 1024
let buffer : byte[] = Array.zeroCreate chunk

let stream = new FileStream("data.bin", FileMode.Open, FileAccess.Read, FileShare.Read)

let mutable total = 0L
let mutable read = stream.Read(buffer, 0, chunk)
while read > 0 do
    for i in 0 .. read - 1 do
        total <- total + int64 buffer.[i]
    read <- stream.Read(buffer, 0, chunk)

stream.Dispose()

printfn "%d" (total % 4294967296L)
