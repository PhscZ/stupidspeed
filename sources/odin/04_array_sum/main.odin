// task 04 array_sum — expected output: 499999500000
// build: odin build . -o:speed    run: ./main
package main

import "core:fmt"

main :: proc() {
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
	fmt.println(total)
}
