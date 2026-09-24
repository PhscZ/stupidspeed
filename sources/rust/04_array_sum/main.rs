// task 04 array_sum — expected output: 499999500000
// build: rustc -O -o prog main.rs    run: ./prog

fn main() {
    let n = 1_000_000usize;
    let mut array = vec![0i64; n];

    for i in 0..n {
        array[i] = i as i64;
    }

    let mut total: i64 = 0;
    for i in 0..n {
        total += array[i];
    }

    println!("{}", total);
}
