// task 02 switch_case — expected output: 7500000075000000
// build: rustc -O -o prog 02_switch_case.rs    run: ./prog
// timing: Instant::now() is std::time's monotonic clock (clock_gettime(CLOCK_MONOTONIC)
//         on Windows and POSIX, clock_time_get on wasip1); TIME_MS goes to stderr with
//         eprintln! and stdout is unchanged.
use std::time::Instant;

fn main() {
    let ss_t0 = Instant::now();
    let t0 = std::time::Instant::now();
    let mut acc: u64 = 0;

    for i in 0..100_000_000u64 {
        match i % 4 {
            0 => acc += 1,
            1 => acc += i,
            2 => acc += 2 * i,
            _ => acc += 3 * i,
        }
    }

    eprintln!("TIME_MS={:.3}", ss_t0.elapsed().as_secs_f64() * 1000.0);
    println!("{}", acc);
}
