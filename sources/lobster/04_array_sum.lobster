// task 04 array_sum — expected output: 499999500000
// build: none (interpreted)    run: lobster 04_array_sum.lobster

// timing: seconds_elapsed() is the VM's monotonic clock (QueryPerformanceCounter on Windows).
// Lobster has no stderr, so the contract's fallback applies: TIME_MS is written to time.txt.
let t_start = seconds_elapsed()

let n = 1000000

let array = []
vector_capacity(array, n)
for(n) i:
    push(array, i)

var total = 0
for array:
    total += _

write_file("time.txt", "TIME_MS=" + string((seconds_elapsed() - t_start) * 1000.0) + "\n")
print total
