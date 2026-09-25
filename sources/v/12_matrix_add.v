// task 12 matrix_add — expected output: 999000000
// build: v -prod -cc gcc -o prog 12_matrix_add.v    run: ./prog
// note: the matrices are flat `[]i64` of n*n, indexed i*n+j, the same layout the C
//       and Rust references use, so the three 8 MB arrays are what is measured.

module main

fn main() {
	n := 1000
	mut a := []i64{len: n * n}
	mut b := []i64{len: n * n}
	mut c := []i64{len: n * n}

	for i in 0 .. n {
		for j in 0 .. n {
			a[i * n + j] = i64(i + j)
			b[i * n + j] = i64(i - j)
		}
	}

	for i in 0 .. n {
		for j in 0 .. n {
			c[i * n + j] = a[i * n + j] + b[i * n + j]
		}
	}

	mut total := i64(0)
	for k in 0 .. n * n {
		total += c[k]
	}

	println(total)
}
