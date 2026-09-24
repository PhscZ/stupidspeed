// task 09 fib_recursive — expected output: 102334155
// build: rustc -O -o prog 09_fib_recursive.rs    run: ./prog

fn fib(n: u64) -> u64 {
    if n < 2 {
        n
    } else {
        fib(n - 1) + fib(n - 2)
    }
}

fn main() {
    println!("{}", fib(40));
}
