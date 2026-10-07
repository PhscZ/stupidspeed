// task 15 file_write — expected output: 52428800
// build: rustc -O -o prog 15_file_write.rs    run: ./prog
// timing: Instant::now() is std::time's monotonic clock (clock_gettime(CLOCK_MONOTONIC)
//         on Windows and POSIX, clock_time_get on wasip1); TIME_MS goes to stderr with
//         eprintln! and stdout is unchanged.
use std::time::Instant;

use std::fs::File;
use std::io::Write;

fn main() {
    let ss_t0 = Instant::now();
    let mut buf = vec![0u8; 1024 * 1024];
    for i in 0..buf.len() {
        buf[i] = (i % 256) as u8;
    }

    let mut file = File::create("out.bin").expect("cannot create out.bin");
    let mut written: u64 = 0;

    for _ in 0..50 {
        file.write_all(&buf).expect("write failed");
        written += buf.len() as u64;
    }

    file.flush().expect("flush failed");
    file.sync_all().expect("sync failed");

    eprintln!("TIME_MS={:.3}", ss_t0.elapsed().as_secs_f64() * 1000.0);
    println!("{}", written);
}
