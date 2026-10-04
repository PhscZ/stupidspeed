// task 07 string_append — expected output: 250000
// build: none (interpreted)    run: lobster 07_string_append.lobster

// timing: seconds_elapsed() is the VM's monotonic clock (QueryPerformanceCounter on Windows).
// Lobster has no stderr, so the contract's fallback applies: TIME_MS is written to time.txt.
let t_start = seconds_elapsed()

var text = ""
for(250000):
    text += "x"

write_file("time.txt", "TIME_MS=" + string((seconds_elapsed() - t_start) * 1000.0) + "\n")
print text.length
