// task 03 func_sum — expected output: 100000000
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 03_func_sum.go    run: tools/wasmtime46/wasmtime.exe prog.wasm
// note: //go:noinline keeps the call real, the same marker the Go row uses.
// note: the build needs tools/tinygo/bin/wasm-opt.exe (binaryen) beside tinygo.exe — the TinyGo
//       release zip ships no wasm-opt, and every wasm target runs it.
package main

import "fmt"

//go:noinline
func addOne(n uint64) uint64 {
	return n + 1
}

func main() {
	var value uint64
	for range 100000000 {
		value = addOne(value)
	}
	fmt.Println(value)
}
