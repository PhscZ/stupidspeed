// task 04 array_sum — expected output: 499999500000
// build: dotnet build -c Release    run: dotnet run

let n = 1000000
let arr : int64[] = Array.zeroCreate n

let mutable i = 0
while i < n do
    arr.[i] <- int64 i
    i <- i + 1

let mutable total = 0L
i <- 0
while i < n do
    total <- total + arr.[i]
    i <- i + 1

printfn "%d" total
