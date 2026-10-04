// task 08 average — expected output: 0.498046875
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 08_average.go    run: tools/wasmtime46/wasmtime.exe prog.wasm
// note: every reading is a multiple of 1/256 and the total stays under 2^53, so the sum is exact.
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
	total := 0.0
	for i := range uint64(100000000) {
		reading := float64(i%256) / 256.0
		total += reading
	}
	average := total / 100000000
	ssReport()
	fmt.Printf("%.9f\n", average)
}
