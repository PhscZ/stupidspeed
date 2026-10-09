// task 02 switch_case — expected output: 7500000075000000
// build: v -prod -cc gcc -o prog 02_switch_case.v    run: ./prog
// note: V has no switch statement; `match` on an integer is the same four-way
//       decision and V emits a C `switch` for it.
// note: the total exceeds 2^32 and V's `int` is 32 bits, so the accumulator is `i64`.

module main

import time

fn main() {
	t0 := time.now()
	mut acc := i64(0)

	for i := i64(0); i < 100000000; i++ {
		match i % 4 {
			0 { acc += 1 }
			1 { acc += i }
			2 { acc += 2 * i }
			3 { acc += 3 * i }
			else {}
		}
	}

	eprintln('TIME_MS=${f64(time.since(t0).microseconds()) / 1000.0:.3f}')
	println(acc)
}
