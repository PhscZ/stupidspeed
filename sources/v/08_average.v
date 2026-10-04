// task 08 average — expected output: 0.498046875
// build: v -prod -cc gcc -o prog 08_average.v    run: ./prog
// note: every reading is a multiple of 1/256 and the total stays under 2^53, so the
//       sum is exact and the printed digits do not depend on the addition order.

module main

import time

fn main() {
	t0 := time.now()
	mut total := 0.0

	for i := 0; i < 100000000; i++ {
		reading := f64(i % 256) / 256.0
		total += reading
	}

	eprintln('TIME_MS=${f64(time.since(t0).microseconds()) / 1000.0:.3f}')
	println(total / f64(100000000))
}
