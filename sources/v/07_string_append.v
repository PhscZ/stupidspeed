// task 07 string_append — expected output: 250000
// build: v -prod -cc gcc -o prog 07_string_append.v    run: ./prog
// note: V strings are immutable and `+` allocates a fresh buffer and copies the old
//       text into it, so this is quadratic — which is what the task measures.

module main

fn main() {
	mut text := ''

	for _ in 0 .. 250000 {
		text = text + 'x'
	}

	println(text.len)
}
