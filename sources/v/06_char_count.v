// task 06 char_count — expected output: 10000000
// build: v -prod -cc gcc -o prog 06_char_count.v    run: ./prog
// note: the 100 MB text is built in one `repeat` call, never by appending.
// note: V strings are byte buffers, so `text[i]` is the i-th byte and is compared
//       against byte literals.

module main

fn main() {
	text := 'abcdefghij'.repeat(10000000)

	mut count := i64(0)
	for i in 0 .. text.len {
		ch := text[i]
		if ch == `a` {
		} else if ch == `e` {
		} else if ch == `h` {
			count++
		} else {
		}
	}

	println(count)
}
