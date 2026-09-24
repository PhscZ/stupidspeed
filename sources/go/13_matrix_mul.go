// task 13 matrix_mul — expected output: 599995000
// build: go build -o prog 13_matrix_mul.go    run: ./prog
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import "fmt"

func main() {
	const n = 500
	a := make([]int64, n*n)
	b := make([]int64, n*n)
	c := make([]int64, n*n)

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			a[i*n+j] = int64((i + j) % 7)
			b[i*n+j] = int64((i * j) % 5)
		}
	}

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			var sum int64
			for k := 0; k < n; k++ {
				sum += a[i*n+k] * b[k*n+j]
			}
			c[i*n+j] = sum
		}
	}

	var total int64
	for _, v := range c {
		total += v
	}
	fmt.Println(total)
}
