// task 02 switch_case — expected output: 7500000075000000
// build: none (interpreted)    run: lobster 02_switch_case.lobster

// timing: seconds_elapsed() is the VM's monotonic clock (QueryPerformanceCounter on Windows).
// Lobster has no stderr, so the contract's fallback applies: TIME_MS is written to time.txt.
let t_start = seconds_elapsed()

var acc = 0

for(100000000) i:
    switch i % 4:
        case 0: acc += 1
        case 1: acc += i
        case 2: acc += 2 * i
        case 3: acc += 3 * i

write_file("time.txt", "TIME_MS=" + string((seconds_elapsed() - t_start) * 1000.0) + "\n")
print acc
