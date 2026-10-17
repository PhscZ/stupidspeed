// task 13 matrix_mul — expected output: 599995000
// build: swiftc -O -o prog 13_matrix_mul.swift    run: ./prog
// timing: Date() is Foundation's wall clock in seconds since the reference date, and
//         timeIntervalSinceDate gives the elapsed time in seconds as a Double; TIME_MS goes
//         to stderr with FileHandle.standardError and stdout is unchanged. Verified on this
//         machine with Swift 6.4: all fifteen tasks print the expected line and the TIME_MS
//         line, once the build passes the -windows-sdk-root flags BUILD.md documents.
import Foundation

func ssReport(_ t0: Date) {
    let ms = Date().timeIntervalSince(t0) * 1000
    FileHandle.standardError.write(("TIME_MS=" + String(format: "%.3f", ms) + "\n").data(using: .utf8)!)
}
let ssT0 = Date()

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

ssReport(ssT0)
print(total)
