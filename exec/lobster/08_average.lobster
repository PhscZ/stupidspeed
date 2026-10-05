// task 08 average — expected output: 0.498046875
// build: none (interpreted)    run: lobster 08_average.lobster

// timing: seconds_elapsed() is the VM's monotonic clock (QueryPerformanceCounter on Windows).
// Lobster has no stderr, so the contract's fallback applies: TIME_MS is written to time.txt.
let t_start = seconds_elapsed()

var total = 0.0

for(100000000) i:
    total += (i % 256) / 256.0

write_file("time.txt", "TIME_MS=" + string((seconds_elapsed() - t_start) * 1000.0) + "\n")
set_print_decimals(9)
print total / 100000000.0
