// task 02 switch_case — expected output: 7500000075000000
// build: rustc -O -o prog main.rs    run: ./prog

fn main() {
    let mut acc: u64 = 0;

    for i in 0..100_000_000u64 {
        match i % 4 {
            0 => acc += 1,
            1 => acc += i,
            2 => acc += 2 * i,
            _ => acc += 3 * i,
        }
    }

    println!("{}", acc);
}
