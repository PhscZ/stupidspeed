// task 05 alloc_churn — expected output: 1274991808
// build: rustc -O -o prog 05_alloc_churn.rs    run: ./prog

fn main() {
    let mut total: u64 = 0;
    let mut slots: [Option<Box<[u8; 64]>>; 256] = std::array::from_fn(|_| None);

    for i in 0..10_000_000u64 {
        let mut buf = Box::new([0u8; 64]);
        buf[0] = (i % 256) as u8;
        total += u64::from(buf[0]);
        // storing into the slot drops the buffer it replaces, which frees it
        slots[(i % 256) as usize] = Some(buf);
    }

    println!("{}", total);
}
