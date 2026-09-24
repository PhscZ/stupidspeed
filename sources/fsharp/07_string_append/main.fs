// task 07 string_append — expected output: 1000000
// build: dotnet build -c Release    run: dotnet run

// System.String is immutable, so every + copies the whole string.
let mutable text = ""
let mutable i = 0
while i < 1000000 do
    text <- text + "x"
    i <- i + 1

printfn "%d" text.Length
