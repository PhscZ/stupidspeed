// task 03 func_sum — expected output: 100000000
// build: rustc -O -o prog 03_func_sum.rs    run: ./prog
// timing: Instant::now() is std::time's monotonic clock (clock_gettime(CLOCK_MONOTONIC)
//         on Windows and POSIX, clock_time_get on wasip1); TIME_MS goes to stderr with
//         eprintln! and stdout is unchanged.
use std::time::Instant;

#[inline(never)]
fn add_one(n: u64) -> u64 {
    n + 1
}

fn main() {
    let ss_t0 = Instant::now();
    let mut value: u64 = 0;

    for _ in 0..100_000_000u64 {
        value = add_one(value);
    }

    eprintln!("TIME_MS={:.3}", ss_t0.elapsed().as_secs_f64() * 1000.0);
    println!("{}", value);
}
