// task 15 file_write — expected output: 419430400
// build: none (interpreted)    run: lobster 15_file_write.lobster   (writes out.bin in this directory)

// timing: seconds_elapsed() is the VM's monotonic clock (QueryPerformanceCounter on Windows).
// Lobster has no stderr, so the contract's fallback applies: TIME_MS is written to time.txt.
let t_start = seconds_elapsed()

// one 1 MiB chunk: the byte cycle 0..255 repeated 4096 times
let chunk = ensure_size("", 1048576, 0)
for(1048576) i:
    write_int8_le(chunk, i, i % 256)

// write_file creates/overwrites, it cannot append, so each pass's 50 chunks are one 50 MiB string
let full = repeat_string(chunk, 50)
var written = 0
for(8) p:
    let n = if write_file("out.bin", full): full.length else: 0
    written += n

write_file("time.txt", "TIME_MS=" + string((seconds_elapsed() - t_start) * 1000.0) + "\n")
print written
