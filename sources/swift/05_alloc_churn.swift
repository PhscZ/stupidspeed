// task 05 alloc_churn — expected output: 1274991808
// build: swiftc -O -o prog 05_alloc_churn.swift    run: ./prog

// 64 real bytes per buffer, 256 slots. Storing the fresh buffer into its slot
// keeps it reachable and releases the buffer it replaces, so the replaced one is
// deallocated explicitly.
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
var total: Int64 = 0
var slots = [UnsafeMutableRawPointer?](repeating: nil, count: 256)

for i in 0..<10_000_000 {
    let buf = UnsafeMutableRawPointer.allocate(byteCount: 64, alignment: 1)
    buf.storeBytes(of: UInt8(i % 256), toByteOffset: 0, as: UInt8.self)
    total += Int64(buf.load(fromByteOffset: 0, as: UInt8.self))

    let slot = i % 256
    slots[slot]?.deallocate()
    slots[slot] = buf
}

for slot in 0..<256 {
    slots[slot]?.deallocate()
    slots[slot] = nil
}

ssReport(ssT0)
print(total)
