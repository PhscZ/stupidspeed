// task 09 fib_recursive — expected output: 102334155
// build: none (interpreted)    run: lobster 09_fib_recursive.lobster

// timing: seconds_elapsed() is the VM's monotonic clock (QueryPerformanceCounter on Windows).
// Lobster has no stderr, so the contract's fallback applies: TIME_MS is written to time.txt.
let t_start = seconds_elapsed()

def fib(n:int) -> int:
    return if n < 2: n else: fib(n - 1) + fib(n - 2)

let answer = fib(40)
write_file("time.txt", "TIME_MS=" + string((seconds_elapsed() - t_start) * 1000.0) + "\n")
print answer
