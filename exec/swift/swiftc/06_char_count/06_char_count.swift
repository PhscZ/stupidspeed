// task 06 char_count — expected output: 10000000
// build: swiftc -O -o prog 06_char_count.swift    run: ./prog

// The 100 MB text is built once, by repeating the ten-character block.
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
let text = String(repeating: "abcdefghij", count: 10_000_000)

// The scan walks the UTF-8 bytes of the string directly; materialising the
// characters into an Array would allocate a hundred million elements first.
var count = 0
text.withCString { ptr in
    for i in 0..<100_000_000 {
        let ch = ptr[i]
        if ch == 0x61 {          // 'a' — skip
            continue
        } else if ch == 0x65 {   // 'e' — skip
            continue
        } else if ch == 0x68 {   // 'h' — count
            count += 1
        }
    }
}

ssReport(ssT0)
print(count)
