// task 14 file_read — expected output: 484442112
// build: swiftc -O -o prog main.swift    run: ./prog

import Foundation

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

print(total % 4294967296)
