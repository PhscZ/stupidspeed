// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 01_branches.go    run: tools/wasmtime46/wasmtime.exe prog.wasm
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
	var a, b, c, d uint64
	for i := range uint64(100000000) {
		if i%3 == 0 {
			a++
		} else if i%5 == 0 {
			b++
		} else if i%7 == 0 {
			c++
		} else {
			d++
		}
	}
	ssReport()
	fmt.Println(a, b, c, d)
}
