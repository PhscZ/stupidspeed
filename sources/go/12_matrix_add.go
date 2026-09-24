// task 12 matrix_add — expected output: 999000000
// build: go build -o prog 12_matrix_add.go    run: ./prog
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import "fmt"

func main() {
	const n = 1000
	a := make([]int64, n*n)
	b := make([]int64, n*n)
	c := make([]int64, n*n)

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			a[i*n+j] = int64(i + j)
			b[i*n+j] = int64(i - j)
		}
	}

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			c[i*n+j] = a[i*n+j] + b[i*n+j]
		}
	}

	var total int64
	for _, v := range c {
		total += v
	}
	fmt.Println(total)
}
