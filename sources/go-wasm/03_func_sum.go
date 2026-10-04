// task 03 func_sum — expected output: 100000000
// build: go build -o prog 03_func_sum.go    run: ./prog
// build (tinygo): tinygo build -o prog.exe 03_func_sum.go    run: ./prog.exe
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

//go:noinline
func addOne(n uint64) uint64 {
	return n + 1
}

func main() {
	ssT0 = time.Now()
	var value uint64
	for i := 0; i < 100000000; i++ {
		value = addOne(value)
	}
	ssReport()
	fmt.Println(value)
}
