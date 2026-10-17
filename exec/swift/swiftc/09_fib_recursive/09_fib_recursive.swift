// task 09 fib_recursive — expected output: 102334155
// build: swiftc -O -o prog 09_fib_recursive.swift    run: ./prog
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

func fib(_ n: Int64) -> Int64 {
    if n < 2 {
        return n
    }
    return fib(n - 1) + fib(n - 2)
}

// the work is evaluated into a variable first: computing it inside the print
// argument list would place all 331 million calls after the timer stops.
let ssR = fib(40)
ssReport(ssT0)
print(ssR)
