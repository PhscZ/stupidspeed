// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: v -prod -cc gcc -o prog 01_branches.v    run: ./prog
// note: `-cc gcc` selects the MinGW-w64 gcc on PATH; without it V falls back to the
//       tcc bundled in thirdparty, which does not optimise the C it is handed.
// note: V's `int` is 32 bits, so the loop index and the four counters are `i64`.

module main

fn main() {
	mut a := i64(0)
	mut b := i64(0)
	mut c := i64(0)
	mut d := i64(0)

	for i := i64(0); i < 100000000; i++ {
		if i % 3 == 0 {
			a++
		} else if i % 5 == 0 {
			b++
		} else if i % 7 == 0 {
			c++
		} else {
			d++
		}
	}

	println('${a} ${b} ${c} ${d}')
}
