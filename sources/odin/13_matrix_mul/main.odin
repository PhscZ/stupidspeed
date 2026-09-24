// task 13 matrix_mul — expected output: 599995000
// build: odin build . -o:speed    run: ./main
package main

import "core:fmt"

N :: 500

main :: proc() {
	a := make([]i64, N * N)
	b := make([]i64, N * N)
	c := make([]i64, N * N)
	defer delete(a)
	defer delete(b)
	defer delete(c)

	for i in 0 ..< N {
		for j in 0 ..< N {
			a[i * N + j] = i64((i + j) % 7)
			b[i * N + j] = i64((i * j) % 5)
		}
	}

	for i in 0 ..< N {
		for j in 0 ..< N {
			s: i64
			for k in 0 ..< N {
				s += a[i * N + k] * b[k * N + j]
			}
			c[i * N + j] = s
		}
	}

	sum: i64
	for i in 0 ..< N * N {
		sum += c[i]
	}
	fmt.println(sum)
}
