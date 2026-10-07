// task 05 alloc_churn — expected output: 1274991808
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 05_alloc_churn.go    run: tools/wasmtime46/wasmtime.exe prog.wasm
// note: wasip1 is built with TinyGo's precise GC, so the ten million 64-byte buffers are really
//       allocated and collected; the slots array keeps each one reachable until it is replaced.
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
	var slots [256][]byte
	var total uint64
	for i := range 10000000 {
		buf := make([]byte, 64)
		buf[0] = byte(i % 256)
		total += uint64(buf[0])
		slots[i%256] = buf
	}
	ssReport()
	fmt.Println(total)
}
