// task 07 string_append — expected output: 250000
// build: v -prod -cc gcc -o prog 07_string_append.v    run: ./prog
// note: V strings are immutable and `+` allocates a fresh buffer and copies the old
//       text into it, so this is quadratic — which is what the task measures.

module main

import time

fn main() {
	t0 := time.now()
	mut text := ''

	for _ in 0 .. 250000 {
		text = text + 'x'
	}

	eprintln('TIME_MS=${f64(time.since(t0).microseconds()) / 1000.0:.3f}')
	println(text.len)
}
