// task 03 func_sum — expected output: 100000000
// build: v -prod -cc gcc -o prog 03_func_sum.v    run: ./prog
// note: add_one lives in the `add_one` module beside this file (add_one/add_one.v),
//       so the call is a real cross-module call and not inlined away. V compiles
//       only the named file plus the modules it imports, so the subdirectory does
//       not disturb the other tasks in this folder.

module main

import add_one

fn main() {
	mut value := i64(0)

	for _ in 0 .. 100000000 {
		value = add_one.add_one(value)
	}

	println(value)
}
