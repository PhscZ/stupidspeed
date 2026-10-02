// task 09 fib_recursive — expected output: 102334155
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 09_fib_recursive.go    run: tools/wasmtime46/wasmtime.exe prog.wasm
// note: the build needs tools/tinygo/bin/wasm-opt.exe (binaryen) beside tinygo.exe — the TinyGo
//       release zip ships no wasm-opt, and every wasm target runs it.
package main

import "fmt"

func fib(n int) int {
	if n < 2 {
		return n
	}
	return fib(n-1) + fib(n-2)
}

func main() {
	fmt.Println(fib(40))
}
