// task 15 file_write — expected output: 52428800
// build: tinygo build -o prog.exe 15_file_write.go    run: ./prog.exe
// TinyGo variant: TinyGo's Windows target implements no fsync — os.File.Sync is a stub that
// returns "operation not implemented" — so this file flushes by closing instead, the same
// deviation the J, SWI-Prolog, Octave, R, Chez, Eiffel, Haxe, Poly/ML, AutoHotkey and Dyalog
// rows already record. The Go/gc row keeps the real f.Sync() in sources/go/.

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
	for range 50 {
		n, err := f.Write(buf)
		if err != nil {
			panic(err)
		}
		written += n
	}

	if err := f.Close(); err != nil {
		panic(err)
	}
	ssReport()
	fmt.Println(written)
}
