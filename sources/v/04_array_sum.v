// task 04 array_sum — expected output: 499999500000
// build: v -prod -cc gcc -o prog 04_array_sum.v    run: ./prog
// note: the sum exceeds 2^32, so the array and the total are `i64`; V's `int` is 32 bits.

module main

import time

fn main() {
	t0 := time.now()
	mut array := []i64{len: 1000000}

	for i in 0 .. 1000000 {
		array[i] = i64(i)
	}

	mut total := i64(0)
	for i in 0 .. 1000000 {
		total += array[i]
	}

	eprintln('TIME_MS=${f64(time.since(t0).microseconds()) / 1000.0:.3f}')
	println(total)
}
