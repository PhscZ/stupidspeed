// task 06 char_count — expected output: 10000000
// build: go build -o prog 06_char_count.go    run: ./prog
// build (tinygo): tinygo build -o prog.exe 06_char_count.go    run: ./prog.exe
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import (
	"fmt"
	"os"
	"strings"
	"time"
)

// timing: time.Now is Go's monotonic clock; TIME_MS goes to stderr and stdout is unchanged.
var ssT0 time.Time

func ssReport() {
	fmt.Fprintf(os.Stderr, "TIME_MS=%.3f\n", float64(time.Since(ssT0).Nanoseconds())/1e6)
}

func main() {
	ssT0 = time.Now()
	text := strings.Repeat("abcdefghij", 10000000)

	count := 0
	for i := range text {
		if text[i] == 'h' {
			count++
		}
	}
	ssReport()
	fmt.Println(count)
}
