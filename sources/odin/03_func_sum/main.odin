// task 03 func_sum — expected output: 100000000
// build: odin build . -o:speed    run: ./main
// Deviation: Odin has no @(no_inline); @(optimization_mode="none") is the real no-inline
// facility (it emits LLVM's "noinline" and "optnone" for the procedure).
package main

import "core:fmt"

@(optimization_mode="none")
add_one :: proc(n: i64) -> i64 {
	return n + 1
}

main :: proc() {
	value: i64
	for _ in 0 ..< 100_000_000 {
		value = add_one(value)
	}
	fmt.println(value)
}
