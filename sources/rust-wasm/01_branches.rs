// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: rustc -O -o prog 01_branches.rs    run: ./prog

fn main() {
    let mut a: u64 = 0;
    let mut b: u64 = 0;
    let mut c: u64 = 0;
    let mut d: u64 = 0;

    for i in 0..100_000_000u64 {
        if i % 3 == 0 {
            a += 1;
        } else if i % 5 == 0 {
            b += 1;
        } else if i % 7 == 0 {
            c += 1;
        } else {
            d += 1;
        }
    }

    println!("{} {} {} {}", a, b, c, d);
}
