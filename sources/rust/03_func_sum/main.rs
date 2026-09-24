// task 03 func_sum — expected output: 100000000
// build: rustc -O -o prog main.rs    run: ./prog

#[inline(never)]
fn add_one(n: u64) -> u64 {
    n + 1
}

fn main() {
    let mut value: u64 = 0;

    for _ in 0..100_000_000u64 {
        value = add_one(value);
    }

    println!("{}", value);
}
