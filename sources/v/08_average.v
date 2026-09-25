// task 08 average — expected output: 0.498046875
// build: v -prod -cc gcc -o prog 08_average.v    run: ./prog
// note: every reading is a multiple of 1/256 and the total stays under 2^53, so the
//       sum is exact and the printed digits do not depend on the addition order.

module main

fn main() {
	mut total := 0.0

	for i := 0; i < 100000000; i++ {
		reading := f64(i % 256) / 256.0
		total += reading
	}

	println(total / f64(100000000))
}
