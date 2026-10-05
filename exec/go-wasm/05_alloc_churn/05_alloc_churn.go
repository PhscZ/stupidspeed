// task 05 alloc_churn — expected output: 1274991808
// build: go build -o prog 05_alloc_churn.go    run: ./prog
// build (tinygo): tinygo build -o prog.exe 05_alloc_churn.go    run: ./prog.exe
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
	var slots [256][]byte
	var total uint64
	for i := 0; i < 10000000; i++ {
		buf := make([]byte, 64)
		buf[0] = byte(i % 256)
		total += uint64(buf[0])
		slots[i%256] = buf
	}
	ssReport()
	fmt.Println(total)
}
