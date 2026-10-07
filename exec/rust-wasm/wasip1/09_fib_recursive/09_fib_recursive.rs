// task 09 fib_recursive — expected output: 102334155
// build: rustc -O -o prog 09_fib_recursive.rs    run: ./prog
// timing: Instant::now() is std::time's monotonic clock (clock_gettime(CLOCK_MONOTONIC)
//         on Windows and POSIX, clock_time_get on wasip1); TIME_MS goes to stderr with
//         eprintln! and stdout is unchanged.
use std::time::Instant;

fn fib(n: u64) -> u64 {
    if n < 2 {
        n
    } else {
        fib(n - 1) + fib(n - 2)
    }
}

fn main() {
    let ss_t0 = Instant::now();
    // the work is evaluated into a variable first: computing it inside the println
    // argument list would place all 331 million calls after the timer stops.
    let ss_r = fib(40);
    eprintln!("TIME_MS={:.3}", ss_t0.elapsed().as_secs_f64() * 1000.0);
    println!("{}", ss_r);
}
