// task 06 char_count — expected output: 10000000
// build: none (interpreted)    run: lobster 06_char_count.lobster

// timing: seconds_elapsed() is the VM's monotonic clock (QueryPerformanceCounter on Windows).
// Lobster has no stderr, so the contract's fallback applies: TIME_MS is written to time.txt.
let t_start = seconds_elapsed()

let block = "abcdefghij"
let text = ensure_size("", 100000000, 0)

for(10000000) i:
    write_substring(text, i * 10, block, 0)

var count = 0
for text:
    if _ == 'h':
        count += 1

write_file("time.txt", "TIME_MS=" + string((seconds_elapsed() - t_start) * 1000.0) + "\n")
print count
