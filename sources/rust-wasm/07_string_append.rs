// task 07 string_append — expected output: 250000
// build: rustc -O -o prog 07_string_append.rs    run: ./prog

fn main() {
    let mut text = String::new();

    for _ in 0..250_000 {
        text = text + "x";
    }

    println!("{}", text.len());
}
