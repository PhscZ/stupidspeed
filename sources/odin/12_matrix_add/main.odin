// task 12 matrix_add — expected output: 999000000
// build: odin build . -o:speed    run: ./main
package main

import "core:fmt"

N :: 1000

main :: proc() {
	a := make([]i64, N * N)
	b := make([]i64, N * N)
	c := make([]i64, N * N)
	defer delete(a)
	defer delete(b)
	defer delete(c)

	for i in 0 ..< N {
		for j in 0 ..< N {
			a[i * N + j] = i64(i + j)
			b[i * N + j] = i64(i - j)
		}
	}

	for i in 0 ..< N {
		for j in 0 ..< N {
			c[i * N + j] = a[i * N + j] + b[i * N + j]
		}
	}

	sum: i64
	for i in 0 ..< N * N {
		sum += c[i]
	}
	fmt.println(sum)
}
