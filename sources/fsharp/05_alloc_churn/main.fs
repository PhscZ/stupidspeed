// task 05 alloc_churn — expected output: 1274991808
// build: dotnet build -c Release    run: dotnet run

let slots : byte[] array = Array.zeroCreate 256

let mutable total = 0L
let mutable i = 0
while i < 10000000 do
    let buf : byte[] = Array.zeroCreate 64
    buf.[0] <- byte (i % 256)
    total <- total + int64 buf.[0]
    // Keeps buf reachable; the buffer it replaces becomes garbage.
    slots.[i % 256] <- buf
    i <- i + 1

printfn "%d" total
