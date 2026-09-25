// task 04 array_sum — expected output: 499999500000
// build: swiftc -O -o prog 04_array_sum.swift    run: ./prog

var array = [Int64](repeating: 0, count: 1_000_000)

for i in 0..<1_000_000 {
    array[i] = Int64(i)
}

var total: Int64 = 0
for i in 0..<1_000_000 {
    total += array[i]
}

print(total)
