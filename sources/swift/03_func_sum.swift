// task 03 func_sum — expected output: 100000000
// build: swiftc -O -o prog 03_func_sum.swift    run: ./prog

// @inline(never) is Swift's own no-inline facility: the hundred million calls
// really go through the call instruction instead of being folded away.
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
@inline(never)
func addOne(_ n: Int64) -> Int64 {
    return n + 1
}

var value: Int64 = 0
for _ in 0..<100_000_000 {
    value = addOne(value)
}

ssReport(ssT0)
print(value)
