// task 02 switch_case — expected output: 7500000075000000
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 02_switch_case.go    run: tools/wasmtime46/wasmtime.exe prog.wasm
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
	var acc uint64
	for i := range uint64(100000000) {
		switch i % 4 {
		case 0:
			acc += 1
		case 1:
			acc += i
		case 2:
			acc += 2 * i
		case 3:
			acc += 3 * i
		}
	}
	ssReport()
	fmt.Println(acc)
}
