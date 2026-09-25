// task 09 fib_recursive — expected output: 102334155
// build: swiftc -O -o prog 09_fib_recursive.swift    run: ./prog

func fib(_ n: Int64) -> Int64 {
    if n < 2 {
        return n
    }
    return fib(n - 1) + fib(n - 2)
}

print(fib(40))
