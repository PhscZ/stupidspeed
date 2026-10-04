// task 13 matrix_mul — expected output: 599995000
// build: odin build 13_matrix_mul.odin -o:speed -out:prog    run: ./prog
package main

import "core:fmt"
import "core:time"

N :: 500

main :: proc() {
	t0 := time.now()
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
	fmt.eprintfln("TIME_MS=%.3f", time.duration_milliseconds(time.since(t0)))
	fmt.println(sum)
}
