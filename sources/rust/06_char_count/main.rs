// task 06 char_count — expected output: 10000000
// build: rustc -O -o prog main.rs    run: ./prog

fn main() {
    // One bulk repeat: 100_000_000 characters, built before the scan.
    let text = "abcdefghij".repeat(10_000_000);

    let mut count: u64 = 0;
    for &ch in text.as_bytes() {
        if ch == b'a' {
            continue;
        } else if ch == b'e' {
            continue;
        } else if ch == b'h' {
            count += 1;
        } else {
            continue;
        }
    }

    println!("{}", count);
}
