// task 08 average — expected output: 0.498046875
// build: swiftc -O -o prog 08_average.swift    run: ./prog
// timing: Date() is Foundation's wall clock in seconds since the reference date, and
//         timeIntervalSinceDate gives the elapsed time in seconds as a Double; TIME_MS goes
//         to stderr with FileHandle.standardError and stdout is unchanged. Verified on this
//         machine with Swift 6.4: all fifteen tasks print the expected line and the TIME_MS
//         line, once the build passes the -windows-sdk-root flags BUILD.md documents.
import Foundation
import Foundation

func ssReport(_ t0: Date) {
    let ms = Date().timeIntervalSince(t0) * 1000
    FileHandle.standardError.write(("TIME_MS=" + String(format: "%.3f", ms) + "\n").data(using: .utf8)!)
}
let ssT0 = Date()


var total = 0.0

for i in 0..<100_000_000 {
    let reading = Double(i % 256) / 256.0
    total += reading
}

// Every reading is a multiple of 1/256 and the sum stays far below 2^53, so the
// result is exact; %.9f prints it as a plain decimal with no locale commas.
ssReport(ssT0)
print(String(format: "%.9f", total / 100_000_000.0))
