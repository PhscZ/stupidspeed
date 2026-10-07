// task 04 array_sum — expected output: 499999500000
// build: swiftc -O -o prog 04_array_sum.swift    run: ./prog
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
