// task 11 parallel_sum — expected output: 7500000075000000
// build: rustc -O -o prog 11_parallel_sum.rs    run: ./prog
// timing: Instant::now() is std::time's monotonic clock (clock_gettime(CLOCK_MONOTONIC)
//         on Windows and POSIX, clock_time_get on wasip1); TIME_MS goes to stderr with
//         eprintln! and stdout is unchanged.
use std::time::Instant;

use std::thread;

fn work(t: u64) -> u64 {
    let mut acc: u64 = 0;

    for i in (t * 25_000_000)..((t + 1) * 25_000_000) {
        match i % 4 {
            0 => acc += 1,
            1 => acc += i,
            2 => acc += 2 * i,
            _ => acc += 3 * i,
        }
    }

    acc
}

fn main() {
    let ss_t0 = Instant::now();
    let mut handles = Vec::new();
    for t in 0..4u64 {
        handles.push(thread::spawn(move || work(t)));
    }

    let mut total: u64 = 0;
    for handle in handles {
        total += handle.join().unwrap();
    }

    eprintln!("TIME_MS={:.3}", ss_t0.elapsed().as_secs_f64() * 1000.0);
    println!("{}", total);
}
