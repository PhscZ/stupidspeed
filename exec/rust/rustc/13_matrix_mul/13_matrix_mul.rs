// task 13 matrix_mul — expected output: 599995000
// build: rustc -O -o prog 13_matrix_mul.rs    run: ./prog
// timing: Instant::now() is std::time's monotonic clock (clock_gettime(CLOCK_MONOTONIC)
//         on Windows and POSIX, clock_time_get on wasip1); TIME_MS goes to stderr with
//         eprintln! and stdout is unchanged.
use std::time::Instant;

fn main() {
    let ss_t0 = Instant::now();
    let n: usize = 500;
    let mut a = vec![0i64; n * n];
    let mut b = vec![0i64; n * n];

    for i in 0..n {
        for j in 0..n {
            a[i * n + j] = ((i + j) % 7) as i64;
            b[i * n + j] = ((i * j) % 5) as i64;
        }
    }

    let mut c = vec![0i64; n * n];
    for i in 0..n {
        for j in 0..n {
            let mut sum: i64 = 0;
            for k in 0..n {
                sum += a[i * n + k] * b[k * n + j];
            }
            c[i * n + j] = sum;
        }
    }

    let mut total: i64 = 0;
    for value in &c {
        total += *value;
    }

    eprintln!("TIME_MS={:.3}", ss_t0.elapsed().as_secs_f64() * 1000.0);
    println!("{}", total);
}
