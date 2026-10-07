// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: swiftc -O -o prog 01_branches.swift    run: ./prog
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

ssReport(ssT0)
print("\(a) \(b) \(c) \(d)")
