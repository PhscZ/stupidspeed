// task 06 char_count — expected output: 10000000
// build: rustc -O -o prog 06_char_count.rs    run: ./prog
// timing: Instant::now() is std::time's monotonic clock (clock_gettime(CLOCK_MONOTONIC)
//         on Windows and POSIX, clock_time_get on wasip1); TIME_MS goes to stderr with
//         eprintln! and stdout is unchanged.
use std::time::Instant;

fn main() {
    let ss_t0 = Instant::now();
    // One bulk repeat: 100_000_000 characters, built before the scan.
    let text = "abcdefghij".repeat(10_000_000);

    let mut count: u64 = 0;
    for &ch in text.as_bytes() {
        if ch == b'a' {
            continue;
        } else if ch == b'e' {
            continue;
        } else if ch == b'h' {
            count += 1;
        } else {
            continue;
        }
    }

    eprintln!("TIME_MS={:.3}", ss_t0.elapsed().as_secs_f64() * 1000.0);
    println!("{}", count);
}
