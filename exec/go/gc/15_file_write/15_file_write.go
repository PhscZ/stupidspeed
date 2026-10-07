// task 15 file_write — expected output: 52428800
// build: go build -o prog 15_file_write.go    run: ./prog
// build (tinygo): tinygo build -o prog.exe 15_file_write.go    run: ./prog.exe
// note (tinygo): the tinygo row builds sources/tinygo/15_file_write.go instead, because
// TinyGo's Windows target has no fsync: os.File.Sync returns "operation not implemented".
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
	buf := make([]byte, 1<<20)
	for i := range buf {
		buf[i] = byte(i % 256)
	}

	f, err := os.Create("out.bin")
	if err != nil {
		panic(err)
	}

	written := 0
	for i := 0; i < 50; i++ {
		n, err := f.Write(buf)
		if err != nil {
			panic(err)
		}
		written += n
	}

	if err := f.Sync(); err != nil {
		panic(err)
	}
	if err := f.Close(); err != nil {
		panic(err)
	}
	ssReport()
	fmt.Println(written)
}
