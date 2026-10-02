// task 15 file_write — expected output: 52428800
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 15_file_write.go    run: tools/wasmtime46/wasmtime.exe --dir=. prog.wasm
// note: run from the directory where out.bin should land; plain `--dir=.` is enough, because
//       wasi-libc strips the leading "." off the preopen name and matches any relative path with
//       the resulting empty prefix (the native Go wasip1 row needs `--dir=<host dir>::/`
//       instead). `--dir=<host dir>::/` also works here; both forms were run.
// note: unlike TinyGo's Windows target, where os.File.Sync is a stub returning "operation not
//       implemented", wasip1 implements it, so the real f.Sync() stays in.
// note: the build needs tools/tinygo/bin/wasm-opt.exe (binaryen) beside tinygo.exe — the TinyGo
//       release zip ships no wasm-opt, and every wasm target runs it.
package main

import (
	"fmt"
	"os"
)

func main() {
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

	if err := f.Sync(); err != nil {
		panic(err)
	}
	if err := f.Close(); err != nil {
		panic(err)
	}
	fmt.Println(written)
}
