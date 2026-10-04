// task 13 matrix_mul — expected output: 599995000
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 13_matrix_mul.go    run: tools/wasmtime46/wasmtime.exe prog.wasm
// note: plain triple loop, no reordering and no blocking, the same shape as the Go row.
// note: the build needs tools/tinygo/bin/wasm-opt.exe (binaryen) beside tinygo.exe — the TinyGo
//       release zip ships no wasm-opt, and every wasm target runs it.
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
	const n = 500
	a := make([]int64, n*n)
	b := make([]int64, n*n)
	c := make([]int64, n*n)

	for i := range n {
		for j := range n {
			a[i*n+j] = int64((i + j) % 7)
			b[i*n+j] = int64((i * j) % 5)
		}
	}

	for i := range n {
		for j := range n {
			var sum int64
			for k := range n {
				sum += a[i*n+k] * b[k*n+j]
			}
			c[i*n+j] = sum
		}
	}

	var total int64
	for _, v := range c {
		total += v
	}
	ssReport()
	fmt.Println(total)
}
