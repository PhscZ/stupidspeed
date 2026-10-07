// task 04 array_sum — expected output: 499999500000
// build: rustc -O -o prog 04_array_sum.rs    run: ./prog
// timing: Instant::now() is std::time's monotonic clock (clock_gettime(CLOCK_MONOTONIC)
//         on Windows and POSIX, clock_time_get on wasip1); TIME_MS goes to stderr with
//         eprintln! and stdout is unchanged.
use std::time::Instant;

fn main() {
    let ss_t0 = Instant::now();
    let n = 1_000_000usize;
    let mut array = vec![0i64; n];

    for i in 0..n {
        array[i] = i as i64;
    }

    let mut total: i64 = 0;
    for i in 0..n {
        total += array[i];
    }

    eprintln!("TIME_MS={:.3}", ss_t0.elapsed().as_secs_f64() * 1000.0);
    println!("{}", total);
}
