// task 14 file_read — expected output: 2389704704
// build: rustc -O -o prog 14_file_read.rs    run: ./prog
// timing: Instant::now() is std::time's monotonic clock (clock_gettime(CLOCK_MONOTONIC)
//         on Windows and POSIX, clock_time_get on wasip1); TIME_MS goes to stderr with
//         eprintln! and stdout is unchanged.
use std::time::Instant;

use std::fs::File;
use std::io::Read;

fn main() {
    let ss_t0 = Instant::now();
    let mut file = File::open("data.bin").expect("cannot open data.bin");
    let mut buf = vec![0u8; 1024 * 1024];
    let mut total: u64 = 0;

    loop {
        let n = file.read(&mut buf).expect("read failed");
        if n == 0 {
            break;
        }
        for i in 0..n {
            total += u64::from(buf[i]);
        }
    }

    eprintln!("TIME_MS={:.3}", ss_t0.elapsed().as_secs_f64() * 1000.0);
    println!("{}", total % 4_294_967_296);
}
