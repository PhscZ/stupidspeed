// task 15 file_write — expected output: 52428800
// build: swiftc -O -o prog 15_file_write.swift    run: ./prog
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


let chunkSize = 1 << 20

// The 1 MiB pattern: the bytes 0..255 repeated 4096 times.
var bytes = [UInt8](repeating: 0, count: chunkSize)
for i in 0..<chunkSize {
    bytes[i] = UInt8(i % 256)
}
let chunk = Data(bytes)

// FileHandle(forWritingAtPath:) needs the file to exist already.
_ = FileManager.default.createFile(atPath: "out.bin", contents: nil)
guard let handle = FileHandle(forWritingAtPath: "out.bin") else {
    fatalError("cannot open out.bin")
}

var written: Int64 = 0
for _ in 0..<50 {
    handle.write(chunk)
    written += Int64(chunk.count)
}

handle.synchronizeFile()
handle.closeFile()

ssReport(ssT0)
print(written)
