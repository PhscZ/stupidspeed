// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: rustc -O -o prog 01_branches.rs    run: ./prog
// timing: Instant::now() is std::time's monotonic clock (clock_gettime(CLOCK_MONOTONIC)
//         on Windows and POSIX, clock_time_get on wasip1); TIME_MS goes to stderr with
//         eprintln! and stdout is unchanged.
use std::time::Instant;

fn main() {
    let ss_t0 = Instant::now();
    let mut a: u64 = 0;
    let mut b: u64 = 0;
    let mut c: u64 = 0;
    let mut d: u64 = 0;

    for i in 0..100_000_000u64 {
        if i % 3 == 0 {
            a += 1;
        } else if i % 5 == 0 {
            b += 1;
        } else if i % 7 == 0 {
            c += 1;
        } else {
            d += 1;
        }
    }

    eprintln!("TIME_MS={:.3}", ss_t0.elapsed().as_secs_f64() * 1000.0);
    println!("{} {} {} {}", a, b, c, d);
}
