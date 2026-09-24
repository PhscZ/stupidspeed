// task 11 parallel_sum — expected output: 7500000075000000
// build: swiftc -O -o prog main.swift    run: ./prog
// concurrency: DispatchQueue.concurrentPerform (libdispatch), which ships with the toolchain

import Dispatch

// The task 02 switch over one quarter of the range.
func partial(_ t: Int64) -> Int64 {
    var acc: Int64 = 0
    let start = t * 25_000_000
    let end = (t + 1) * 25_000_000
    for i in start..<end {
        switch i % 4 {
        case 0:
            acc += 1
        case 1:
            acc += i
        case 2:
            acc += 2 * i
        default:
            acc += 3 * i
        }
    }
    return acc
}

var partials = [Int64](repeating: 0, count: 4)

// Each worker writes its own index through the buffer pointer, so the four
// threads never touch the same memory and never race on the array itself.
partials.withUnsafeMutableBufferPointer { buf in
    DispatchQueue.concurrentPerform(iterations: 4) { t in
        buf[t] = partial(Int64(t))
    }
}

var total: Int64 = 0
for p in partials {
    total += p
}

print(total)
