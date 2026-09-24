// task 03 func_sum — expected output: 100000000
// build: dotnet build -c Release 03_func_sum.fsproj    run: dotnet run -c Release (or bin/Release/net8.0/03_func_sum.dll)

open System.Runtime.CompilerServices

// Not inlinable, so the hundred million calls really happen.
[<MethodImpl(MethodImplOptions.NoInlining)>]
let addOne (n: int64) : int64 = n + 1L

let mutable value = 0L
let mutable i = 0
while i < 100000000 do
    value <- addOne value
    i <- i + 1

printfn "%d" value
