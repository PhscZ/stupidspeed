// task 08 average — expected output: 0.498046875
// build: rustc -O -o prog main.rs    run: ./prog

fn main() {
    let mut total: f64 = 0.0;

    for i in 0..100_000_000u64 {
        let reading = (i % 256) as f64 / 256.0;
        total += reading;
    }

    println!("{:.9}", total / 100_000_000.0);
}
