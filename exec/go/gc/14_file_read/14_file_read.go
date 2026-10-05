// task 14 file_read — expected output: 2389704704
// build: go build -o prog 14_file_read.go    run: ./prog
// build (tinygo): tinygo build -o prog.exe 14_file_read.go    run: ./prog.exe
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import (
	"fmt"
	"io"
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
	f, err := os.Open("data.bin")
	if err != nil {
		panic(err)
	}
	defer f.Close()

	buf := make([]byte, 1<<20)
	var total uint64
	for {
		n, err := f.Read(buf)
		for i := 0; i < n; i++ {
			total += uint64(buf[i])
		}
		if err == io.EOF {
			break
		}
		if err != nil {
			panic(err)
		}
	}
	ssReport()
	fmt.Println(total % 4294967296)
}
