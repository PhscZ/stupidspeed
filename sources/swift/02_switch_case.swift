// task 02 switch_case — expected output: 7500000075000000
// build: swiftc -O -o prog 02_switch_case.swift    run: ./prog
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

ssReport(ssT0)
print(acc)
