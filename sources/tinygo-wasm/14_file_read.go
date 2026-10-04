// task 14 file_read — expected output: 2389704704
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 14_file_read.go    run: tools/wasmtime46/wasmtime.exe --dir=. prog.wasm
// note: run from a directory holding data.bin (50 MiB). Plain `--dir=.` is enough here, because
//       TinyGo links wasi-libc, whose __wasilibc_register_preopened_fd strips the leading "/"
//       and "./" off each preopen name: the preopen named "." therefore registers as the empty
//       prefix, and prefix_matches accepts an empty prefix for any relative path. The native Go
//       wasip1 row needs `--dir=<host dir>::/` instead, because Go opens its preopens by WASI
//       name and expects "/". `--dir=<host dir>::/` also works here; both forms were run.
// note: the build needs tools/tinygo/bin/wasm-opt.exe (binaryen) beside tinygo.exe — the TinyGo
//       release zip ships no wasm-opt, and every wasm target runs it.
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
		for i := range n {
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
