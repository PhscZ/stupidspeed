// task 06 char_count — expected output: 10000000
// build: dotnet build -c Release    run: dotnet run

// The whole 100 MB text is built in one operation, not by appending.
let text = String.replicate 10000000 "abcdefghij"

let mutable count = 0L
let len = text.Length
let mutable i = 0
while i < len do
    let ch = text.[i]
    if ch = 'a' then
        ()
    elif ch = 'e' then
        ()
    elif ch = 'h' then
        count <- count + 1L
    else
        ()
    i <- i + 1

printfn "%d" count
