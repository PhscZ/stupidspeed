// task 03 func_sum — expected output: 100000000
// build: v -prod -cc gcc -o prog 03_func_sum.v    run: ./prog
// note: `-cc gcc` selects the MinGW-w64 gcc on PATH; without it V falls back to the
//       tcc bundled in thirdparty, which does not optimise the C it is handed.
// note: @[noinline] is V's own no-inline facility, the same role
//       __attribute__((noinline)) plays in the C reference and @inline(never) in Swift.
//       Without it -prod folds add_one into the loop and the hundred million calls vanish.

module main

@[noinline]
fn add_one(n i64) i64 {
	return n + 1
}

fn main() {
	mut value := i64(0)

	for _ in 0 .. 100000000 {
		value = add_one(value)
	}

	println(value)
}
