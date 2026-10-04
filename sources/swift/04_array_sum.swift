// task 04 array_sum — expected output: 499999500000
// build: swiftc -O -o prog 04_array_sum.swift    run: ./prog
// timing: Date() is Foundation's wall clock in seconds since the reference date, and
//         timeIntervalSinceDate gives the elapsed time in seconds as a Double; TIME_MS goes
//         to stderr with FileHandle.standardError and stdout is unchanged. Instrumented by
//         inspection: the installed Swift toolchain cannot compile on this machine (missing
//         _complex and ucrt Swift modules), so this row's timing is unverified.
import Foundation

func ssReport(_ t0: Date) {
    let ms = Date().timeIntervalSince(t0) * 1000
    FileHandle.standardError.write("TIME_MS=" + String(format: "%.3f", ms) + "\n".data(using: .utf8)!)
}
let ssT0 = Date()

var array = [Int64](repeating: 0, count: 1_000_000)

for i in 0..<1_000_000 {
    array[i] = Int64(i)
}

var total: Int64 = 0
for i in 0..<1_000_000 {
    total += array[i]
}

ssReport(ssT0)
print(total)
