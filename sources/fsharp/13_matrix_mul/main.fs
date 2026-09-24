// task 13 matrix_mul — expected output: 599995000
// build: dotnet build -c Release    run: dotnet run

let n = 500
let size = n * n

let a : int64[] = Array.zeroCreate size
let b : int64[] = Array.zeroCreate size
let c : int64[] = Array.zeroCreate size

for i in 0 .. n - 1 do
    for j in 0 .. n - 1 do
        a.[i * n + j] <- int64 ((i + j) % 7)
        b.[i * n + j] <- int64 ((i * j) % 5)

// Plain i, j, k triple loop in that order.
for i in 0 .. n - 1 do
    for j in 0 .. n - 1 do
        let mutable sum = 0L
        for k in 0 .. n - 1 do
            sum <- sum + a.[i * n + k] * b.[k * n + j]
        c.[i * n + j] <- sum

let mutable total = 0L
for idx in 0 .. size - 1 do
    total <- total + c.[idx]

printfn "%d" total
