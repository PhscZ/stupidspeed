// task 08 average — expected output: 0.498046875
// build: rustc -O -o prog 08_average.rs    run: ./prog
// timing: Instant::now() is std::time's monotonic clock (clock_gettime(CLOCK_MONOTONIC)
//         on Windows and POSIX, clock_time_get on wasip1); TIME_MS goes to stderr with
//         eprintln! and stdout is unchanged.
use std::time::Instant;

fn main() {
    let ss_t0 = Instant::now();
    let mut total: f64 = 0.0;

    for i in 0..100_000_000u64 {
        let reading = (i % 256) as f64 / 256.0;
        total += reading;
    }

    eprintln!("TIME_MS={:.3}", ss_t0.elapsed().as_secs_f64() * 1000.0);
    println!("{:.9}", total / 100_000_000.0);
}
