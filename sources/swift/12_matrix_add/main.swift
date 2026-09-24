// task 12 matrix_add — expected output: 999000000
// build: swiftc -O -o prog main.swift    run: ./prog

let n = 1000
var a = [Int64](repeating: 0, count: n * n)
var b = [Int64](repeating: 0, count: n * n)
var c = [Int64](repeating: 0, count: n * n)

for i in 0..<n {
    for j in 0..<n {
        a[i * n + j] = Int64(i + j)
    }
}

for i in 0..<n {
    for j in 0..<n {
        b[i * n + j] = Int64(i - j)
    }
}

for i in 0..<n {
    for j in 0..<n {
        c[i * n + j] = a[i * n + j] + b[i * n + j]
    }
}

var total: Int64 = 0
for idx in 0..<(n * n) {
    total += c[idx]
}

print(total)
