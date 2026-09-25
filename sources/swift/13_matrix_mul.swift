// task 13 matrix_mul — expected output: 599995000
// build: swiftc -O -o prog 13_matrix_mul.swift    run: ./prog

let n = 500
var a = [Int64](repeating: 0, count: n * n)
var b = [Int64](repeating: 0, count: n * n)
var c = [Int64](repeating: 0, count: n * n)

for i in 0..<n {
    for j in 0..<n {
        a[i * n + j] = Int64((i + j) % 7)
    }
}

for i in 0..<n {
    for j in 0..<n {
        b[i * n + j] = Int64((i * j) % 5)
    }
}

// The plain i, j, k triple loop, in that order.
for i in 0..<n {
    for j in 0..<n {
        var sum: Int64 = 0
        for k in 0..<n {
            sum += a[i * n + k] * b[k * n + j]
        }
        c[i * n + j] = sum
    }
}

var total: Int64 = 0
for idx in 0..<(n * n) {
    total += c[idx]
}

print(total)
