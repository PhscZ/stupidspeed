// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: swiftc -O -o prog main.swift    run: ./prog

var a: Int64 = 0
var b: Int64 = 0
var c: Int64 = 0
var d: Int64 = 0

for i in Int64(0)..<Int64(100_000_000) {
    if i % 3 == 0 {
        a += 1
    } else if i % 5 == 0 {
        b += 1
    } else if i % 7 == 0 {
        c += 1
    } else {
        d += 1
    }
}

print("\(a) \(b) \(c) \(d)")
