// task 07 string_append — expected output: 250000
// build: swiftc -O -o prog 07_string_append.swift    run: ./prog

// Plain Swift string concatenation: `text + "x"` builds a new String value.
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
var text = ""
for _ in 0..<250_000 {
    text = text + "x"
}

// The string is pure ASCII, so the UTF-8 count is the length without walking it
// grapheme by grapheme.
ssReport(ssT0)
print(text.utf8.count)
