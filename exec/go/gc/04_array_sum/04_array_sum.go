// task 04 array_sum — expected output: 599999940000000
// build: go build -o prog 04_array_sum.go    run: ./prog
// build (tinygo): tinygo build -o prog.exe 04_array_sum.go    run: ./prog.exe
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
	arr := make([]int64, 10000000)
	for i := 0; i < 10000000; i++ {
		arr[i] = int64(i)
	}

	var total int64
	for pass := 0; pass < 12; pass++ {
		for i := 0; i < 10000000; i++ {
			total += arr[i]
		}
	}
	ssReport()
	fmt.Println(total)
}
