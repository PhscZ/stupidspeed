// task 03 func_sum — expected output: 100000000
// build: swiftc -O -o prog main.swift    run: ./prog

// @inline(never) is Swift's own no-inline facility: the hundred million calls
// really go through the call instruction instead of being folded away.
@inline(never)
func addOne(_ n: Int64) -> Int64 {
    return n + 1
}

var value: Int64 = 0
for _ in 0..<100_000_000 {
    value = addOne(value)
}

print(value)
