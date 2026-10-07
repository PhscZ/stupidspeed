// task 04 array_sum — expected output: 499999500000
// build: odin build 04_array_sum.odin -o:speed -out:prog    run: ./prog
package main

import "core:fmt"
import "core:time"

main :: proc() {
	t0 := time.now()
	N :: 1_000_000
	array := make([]i64, N)
	defer delete(array)

	for i in 0 ..< N {
		array[i] = i64(i)
	}

	total: i64
	for i in 0 ..< N {
		total += array[i]
	}
	fmt.eprintfln("TIME_MS=%.3f", time.duration_milliseconds(time.since(t0)))
	fmt.println(total)
}
