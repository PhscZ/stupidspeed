// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: none (interpreted)    run: lobster 01_branches.lobster

// timing: seconds_elapsed() is the VM's monotonic clock (QueryPerformanceCounter on Windows).
// Lobster has no stderr, so the contract's fallback applies: TIME_MS is written to time.txt.
let t_start = seconds_elapsed()

var a = 0
var b = 0
var c = 0
var d = 0

for(100000000) i:
    if i % 3 == 0:
        a += 1
    elif i % 5 == 0:
        b += 1
    elif i % 7 == 0:
        c += 1
    else:
        d += 1

write_file("time.txt", "TIME_MS=" + string((seconds_elapsed() - t_start) * 1000.0) + "\n")
print "{a} {b} {c} {d}"
