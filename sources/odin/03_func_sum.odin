// task 03 func_sum — expected output: 100000000
// build: odin build 03_func_sum.odin -o:speed -out:prog    run: ./prog
// Deviation: Odin has no @(no_inline); @(optimization_mode="none") is the real no-inline
// facility (it emits LLVM's "noinline" and "optnone" for the procedure).
package main

import "core:fmt"
import "core:time"

@(optimization_mode="none")
add_one :: proc(n: i64) -> i64 {
	return n + 1
}

main :: proc() {
	t0 := time.now()
	value: i64
	for _ in 0 ..< 100_000_000 {
		value = add_one(value)
	}
	fmt.eprintfln("TIME_MS=%.3f", time.duration_milliseconds(time.since(t0)))
	fmt.println(value)
}
