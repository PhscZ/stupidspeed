// task 02 switch_case — expected output: 7500000075000000
// build: swiftc -O -o prog main.swift    run: ./prog

var acc: Int64 = 0

for i in Int64(0)..<Int64(100_000_000) {
    switch i % 4 {
    case 0:
        acc += 1
    case 1:
        acc += i
    case 2:
        acc += 2 * i
    default:
        acc += 3 * i
    }
}

print(acc)
