// task 13 matrix_mul — expected output: 599995000
// build: v -prod -cc gcc -o prog 13_matrix_mul.v    run: ./prog
// note: plain i, j, k triple loop in that order, flat n*n arrays; reordering the
//       loops would be faster, which is the point of the task.

module main

import time

fn main() {
	t0 := time.now()
	n := 500
	mut a := []i64{len: n * n}
	mut b := []i64{len: n * n}
	mut c := []i64{len: n * n}

	for i in 0 .. n {
		for j in 0 .. n {
			a[i * n + j] = i64((i + j) % 7)
			b[i * n + j] = i64((i * j) % 5)
		}
	}

	for i in 0 .. n {
		for j in 0 .. n {
			mut sum := i64(0)
			for k in 0 .. n {
				sum += a[i * n + k] * b[k * n + j]
			}
			c[i * n + j] = sum
		}
	}

	mut total := i64(0)
	for k in 0 .. n * n {
		total += c[k]
	}

	eprintln('TIME_MS=${f64(time.since(t0).microseconds()) / 1000.0:.3f}')
	println(total)
}
