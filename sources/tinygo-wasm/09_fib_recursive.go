// task 09 fib_recursive — expected output: 102334155
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 09_fib_recursive.go    run: tools/wasmtime46/wasmtime.exe prog.wasm
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
