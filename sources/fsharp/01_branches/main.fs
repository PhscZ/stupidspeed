// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: dotnet build -c Release    run: dotnet run

let mutable a = 0L
let mutable b = 0L
let mutable c = 0L
let mutable d = 0L

let mutable i = 0L
while i < 100000000L do
    if i % 3L = 0L then
        a <- a + 1L
    elif i % 5L = 0L then
        b <- b + 1L
    elif i % 7L = 0L then
        c <- c + 1L
    else
        d <- d + 1L
    i <- i + 1L

printfn "%d %d %d %d" a b c d
