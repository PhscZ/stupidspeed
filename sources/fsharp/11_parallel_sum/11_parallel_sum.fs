// task 11 parallel_sum — expected output: 7500000075000000
// build: dotnet build -c Release 11_parallel_sum.fsproj    run: dotnet run -c Release (or bin/Release/net8.0/11_parallel_sum.dll)

open System.Threading

let work (t: int64) : int64 =
    let mutable acc = 0L
    let stop = (t + 1L) * 25000000L
    let mutable i = t * 25000000L
    while i < stop do
        match i % 4L with
        | 0L -> acc <- acc + 1L
        | 1L -> acc <- acc + i
        | 2L -> acc <- acc + 2L * i
        | _ -> acc <- acc + 3L * i
        i <- i + 1L
    acc

let results : int64[] = Array.zeroCreate 4

let threads : Thread[] =
    Array.init 4 (fun t ->
        let index = t
        Thread(ThreadStart(fun () -> results.[index] <- work (int64 index))))

for th in threads do
    th.Start()

for th in threads do
    th.Join()

let mutable total = 0L
for r in results do
    total <- total + r

printfn "%d" total
