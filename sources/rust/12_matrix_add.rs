// task 12 matrix_add — expected output: 999000000
// build: rustc -O -o prog 12_matrix_add.rs    run: ./prog
// timing: Instant::now() is std::time's monotonic clock (clock_gettime(CLOCK_MONOTONIC)
//         on Windows and POSIX, clock_time_get on wasip1); TIME_MS goes to stderr with
//         eprintln! and stdout is unchanged.
use std::time::Instant;

fn main() {
    let ss_t0 = Instant::now();
    let n: usize = 1000;
    let mut a = vec![0i64; n * n];
    let mut b = vec![0i64; n * n];

    for i in 0..n {
        for j in 0..n {
            a[i * n + j] = i as i64 + j as i64;
            b[i * n + j] = i as i64 - j as i64;
        }
    }

    let mut c = vec![0i64; n * n];
    for i in 0..n {
        for j in 0..n {
            c[i * n + j] = a[i * n + j] + b[i * n + j];
        }
    }

    let mut total: i64 = 0;
    for value in &c {
        total += *value;
    }

    eprintln!("TIME_MS={:.3}", ss_t0.elapsed().as_secs_f64() * 1000.0);
    println!("{}", total);
}
