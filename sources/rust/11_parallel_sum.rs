// task 11 parallel_sum — expected output: 7500000075000000
// build: rustc -O -o prog 11_parallel_sum.rs    run: ./prog

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
    let mut handles = Vec::new();
    for t in 0..4u64 {
        handles.push(thread::spawn(move || work(t)));
    }

    let mut total: u64 = 0;
    for handle in handles {
        total += handle.join().unwrap();
    }

    println!("{}", total);
}
