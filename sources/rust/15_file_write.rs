// task 15 file_write — expected output: 104857600
// build: rustc -O -o prog 15_file_write.rs    run: ./prog

use std::fs::File;
use std::io::Write;

fn main() {
    let mut buf = vec![0u8; 1024 * 1024];
    for i in 0..buf.len() {
        buf[i] = (i % 256) as u8;
    }

    let mut file = File::create("out.bin").expect("cannot create out.bin");
    let mut written: u64 = 0;

    for _ in 0..100 {
        file.write_all(&buf).expect("write failed");
        written += buf.len() as u64;
    }

    file.flush().expect("flush failed");
    file.sync_all().expect("sync failed");

    println!("{}", written);
}
