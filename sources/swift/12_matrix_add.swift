// task 12 matrix_add — expected output: 999000000
// build: swiftc -O -o prog 12_matrix_add.swift    run: ./prog
// timing: Date() is Foundation's wall clock in seconds since the reference date, and
//         timeIntervalSinceDate gives the elapsed time in seconds as a Double; TIME_MS goes
//         to stderr with FileHandle.standardError and stdout is unchanged. Instrumented by
//         inspection: the installed Swift toolchain cannot compile on this machine (missing
//         _complex and ucrt Swift modules), so this row's timing is unverified.
import Foundation

func ssReport(_ t0: Date) {
    let ms = Date().timeIntervalSince(t0) * 1000
    FileHandle.standardError.write(("TIME_MS=" + String(format: "%.3f", ms) + "\n").data(using: .utf8)!)
}
let ssT0 = Date()

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

ssReport(ssT0)
print(total)
