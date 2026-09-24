// task 10 pi — expected output: 44889
// build: dotnet build -c Release    run: dotnet run

open System.Numerics

// Gibbons' unbounded spigot, on BigInteger. Emits the leading 3 first,
// then one decimal digit of pi at a time. Only the digit sum is printed.
let zero = BigInteger.Zero
let one = BigInteger.One
let two = BigInteger(2)
let three = BigInteger(3)
let four = BigInteger(4)
let seven = BigInteger(7)
let ten = BigInteger(10)

let mutable q = one
let mutable r = zero
let mutable t = one
let mutable k = one
let mutable n = three
let mutable l = three

let mutable emitted = 0
let mutable sum = 0

while emitted < 10000 do
    if four * q + r - t < n * t then
        sum <- sum + int n
        emitted <- emitted + 1
        if emitted < 10000 then
            let nNext = (ten * (three * q + r)) / t - ten * n
            q <- ten * q
            r <- ten * (r - n * t)
            n <- nNext
    else
        let qNext = q * k
        let rNext = (two * q + r) * l
        let tNext = t * l
        let kNext = k + one
        let nNext = (q * (seven * k + two) + r * l) / (t * l)
        q <- qNext
        r <- rNext
        t <- tNext
        k <- kNext
        n <- nNext
        l <- l + two

printfn "%d" sum
