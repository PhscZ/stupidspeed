// task 09 fib_recursive — expected output: 102334155
// build: dotnet build -c Release 09_fib_recursive.fsproj    run: dotnet run -c Release (or bin/Release/net8.0/09_fib_recursive.dll)

let rec fib (n: int64) : int64 =
    if n < 2L then n
    else fib (n - 1L) + fib (n - 2L)

printfn "%d" (fib 40L)
