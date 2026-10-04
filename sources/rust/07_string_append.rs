// task 07 string_append — expected output: 250000
// build: rustc -O -o prog 07_string_append.rs    run: ./prog
// timing: Instant::now() is std::time's monotonic clock (clock_gettime(CLOCK_MONOTONIC)
//         on Windows and POSIX, clock_time_get on wasip1); TIME_MS goes to stderr with
//         eprintln! and stdout is unchanged.
use std::time::Instant;

fn main() {
    let ss_t0 = Instant::now();
    let mut text = String::new();

    for _ in 0..250_000 {
        text = text + "x";
    }

    eprintln!("TIME_MS={:.3}", ss_t0.elapsed().as_secs_f64() * 1000.0);
    println!("{}", text.len());
}
