// task 07 string_append — expected output: 1000000
// build: dotnet build -c Release 07_string_append.fsproj    run: dotnet run -c Release (or bin/Release/net8.0/07_string_append.dll)

// System.String is immutable, so every + copies the whole string.
let mutable text = ""
let mutable i = 0
while i < 1000000 do
    text <- text + "x"
    i <- i + 1

printfn "%d" text.Length
