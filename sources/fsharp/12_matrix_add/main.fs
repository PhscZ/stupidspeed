// task 12 matrix_add — expected output: 999000000
// build: dotnet build -c Release    run: dotnet run

let n = 1000
let size = n * n

let a : int64[] = Array.zeroCreate size
let b : int64[] = Array.zeroCreate size
let c : int64[] = Array.zeroCreate size

for i in 0 .. n - 1 do
    for j in 0 .. n - 1 do
        a.[i * n + j] <- int64 (i + j)
        b.[i * n + j] <- int64 (i - j)

for idx in 0 .. size - 1 do
    c.[idx] <- a.[idx] + b.[idx]

let mutable total = 0L
for idx in 0 .. size - 1 do
    total <- total + c.[idx]

printfn "%d" total
