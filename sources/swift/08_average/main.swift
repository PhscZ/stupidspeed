// task 08 average — expected output: 0.498046875
// build: swiftc -O -o prog main.swift    run: ./prog

import Foundation

var total = 0.0

for i in 0..<100_000_000 {
    let reading = Double(i % 256) / 256.0
    total += reading
}

// Every reading is a multiple of 1/256 and the sum stays far below 2^53, so the
// result is exact; %.9f prints it as a plain decimal with no locale commas.
print(String(format: "%.9f", total / 100_000_000.0))
