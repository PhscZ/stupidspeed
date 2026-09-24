// task 02 switch_case — expected output: 7500000075000000
// build: dotnet build -c Release 02_switch_case.fsproj    run: dotnet run -c Release (or bin/Release/net8.0/02_switch_case.dll)

let mutable acc = 0L

let mutable i = 0L
while i < 100000000L do
    match i % 4L with
    | 0L -> acc <- acc + 1L
    | 1L -> acc <- acc + i
    | 2L -> acc <- acc + 2L * i
    | _ -> acc <- acc + 3L * i
    i <- i + 1L

printfn "%d" acc
