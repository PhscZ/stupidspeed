// task 09 fib_recursive — expected output: 102334155
// build: odin build 09_fib_recursive.odin -o:speed -out:prog    run: ./prog
package main

import "core:fmt"
import "core:time"

fib :: proc(n: i64) -> i64 {
	if n < 2 {
		return n
	}
	return fib(n - 1) + fib(n - 2)
}

main :: proc() {
	t0 := time.now()
	result := fib(40)
	fmt.eprintfln("TIME_MS=%.3f", time.duration_milliseconds(time.since(t0)))
	fmt.println(result)
}
