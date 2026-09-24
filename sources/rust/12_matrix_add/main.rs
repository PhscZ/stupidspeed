// task 12 matrix_add — expected output: 999000000
// build: rustc -O -o prog main.rs    run: ./prog

fn main() {
    let n: usize = 1000;
    let mut a = vec![0i64; n * n];
    let mut b = vec![0i64; n * n];

    for i in 0..n {
        for j in 0..n {
            a[i * n + j] = i as i64 + j as i64;
            b[i * n + j] = i as i64 - j as i64;
        }
    }

    let mut c = vec![0i64; n * n];
    for i in 0..n {
        for j in 0..n {
            c[i * n + j] = a[i * n + j] + b[i * n + j];
        }
    }

    let mut total: i64 = 0;
    for value in &c {
        total += *value;
    }

    println!("{}", total);
}
