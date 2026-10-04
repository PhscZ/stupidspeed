// task 14 file_read — expected output: 2389704704
// build: swiftc -O -o prog 14_file_read.swift    run: ./prog
// timing: Date() is Foundation's wall clock in seconds since the reference date, and
//         timeIntervalSinceDate gives the elapsed time in seconds as a Double; TIME_MS goes
//         to stderr with FileHandle.standardError and stdout is unchanged. Instrumented by
//         inspection: the installed Swift toolchain cannot compile on this machine (missing
//         _complex and ucrt Swift modules), so this row's timing is unverified.
import Foundation
import Foundation

func ssReport(_ t0: Date) {
    let ms = Date().timeIntervalSince(t0) * 1000
    FileHandle.standardError.write("TIME_MS=" + String(format: "%.3f", ms) + "\n".data(using: .utf8)!)
}
let ssT0 = Date()


let chunkSize = 1 << 20

guard let handle = FileHandle(forReadingAtPath: "data.bin") else {
    fatalError("cannot open data.bin")
}

var total: UInt64 = 0

// One mebibyte per read; a read of nil or of zero bytes means end of file.
while true {
    guard let chunk = try? handle.read(upToCount: chunkSize), !chunk.isEmpty else {
        break
    }
    for byte in chunk {
        total += UInt64(byte)
    }
}

handle.closeFile()

ssReport(ssT0)
print(total % 4294967296)
