// task 08 average — expected output: 0.498046875
// build: go build -o prog 08_average.go    run: ./prog
// build (wasip1): GOOS=wasip1 GOARCH=wasm go build -o prog.wasm 08_average.go    run: wasmtime prog.wasm
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
	total := 0.0
	for i := uint64(0); i < 200000000; i++ {
		reading := float64(i%256) / 256.0
		total += reading
	}
	average := total / 200000000
	ssReport()
	fmt.Printf("%.9f\n", average)
}
