// task 15 file_write — expected output: 104857600
// build: swiftc -O -o prog 15_file_write.swift    run: ./prog

import Foundation

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
for _ in 0..<100 {
    handle.write(chunk)
    written += Int64(chunk.count)
}

handle.synchronizeFile()
handle.closeFile()

print(written)
