// task 12 matrix_add — expected output: 999000000
// build: go build -o prog 12_matrix_add.go    run: ./prog
// build (tinygo): tinygo build -o prog.exe 12_matrix_add.go    run: ./prog.exe
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import (
	"fmt"
	"os"
	"time"
)

// timing: time.Now is Go's monotonic clock; TIME_MS goes to stderr and stdout is unchanged.
var ssT0 time.Time

func ssReport() {
	fmt.Fprintf(os.Stderr, "TIME_MS=%.3f\n", float64(time.Since(ssT0).Nanoseconds())/1e6)
}

func main() {
	ssT0 = time.Now()
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
	ssReport()
	fmt.Println(total)
}
