// task 14 file_read — expected output: 2389704704
// build: none (interpreted)    run: lobster 14_file_read.lobster   (from this directory, with data.bin beside it)

// timing: seconds_elapsed() is the VM's monotonic clock (QueryPerformanceCounter on Windows).
// Lobster has no stderr, so the contract's fallback applies: TIME_MS is written to time.txt.
let t_start = seconds_elapsed()

let data = assert read_file("data.bin")

var total = 0
for data:
    total += _

write_file("time.txt", "TIME_MS=" + string((seconds_elapsed() - t_start) * 1000.0) + "\n")
print total % 4294967296
