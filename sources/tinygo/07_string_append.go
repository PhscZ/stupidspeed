// task 07 string_append — expected output: 250000
// build: go build -o prog 07_string_append.go    run: ./prog
// build (tinygo): tinygo build -o prog.exe 07_string_append.go    run: ./prog.exe
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
	text := ""
	for i := 0; i < 250000; i++ {
		text += "x"
	}
	ssReport()
	fmt.Println(len(text))
}
