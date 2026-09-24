// task 14 file_read — expected output: 484442112
// build: rustc -O -o prog 14_file_read.rs    run: ./prog

use std::fs::File;
use std::io::Read;

fn main() {
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

    println!("{}", total % 4_294_967_296);
}
