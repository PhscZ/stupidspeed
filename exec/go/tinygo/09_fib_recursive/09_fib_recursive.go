// task 09 fib_recursive — expected output: 102334155
// build: go build -o prog 09_fib_recursive.go    run: ./prog
// build (tinygo): tinygo build -o prog.exe 09_fib_recursive.go    run: ./prog.exe
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

func fib(n int) int {
	if n < 2 {
		return n
	}
	return fib(n-1) + fib(n-2)
}

func main() {
	ssT0 = time.Now()
	// fib(40) is evaluated into a variable first: computing it inside the Println
	// argument list would place all 331 million calls after the timer stops.
	ssR := fib(40)
	ssReport()
	fmt.Println(ssR)
}
