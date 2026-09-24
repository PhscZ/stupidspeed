// task 05 alloc_churn — expected output: 1274991808
// build: swiftc -O -o prog main.swift    run: ./prog

// 64 real bytes per buffer, 256 slots. Storing the fresh buffer into its slot
// keeps it reachable and releases the buffer it replaces, so the replaced one is
// deallocated explicitly.
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

print(total)
