// task 04 array_sum — expected output: 499999500000
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 04_array_sum.go    run: tools/wasmtime46/wasmtime.exe prog.wasm
// note: the build needs tools/tinygo/bin/wasm-opt.exe (binaryen) beside tinygo.exe — the TinyGo
//       release zip ships no wasm-opt, and every wasm target runs it.
package main

import "fmt"

func main() {
	arr := make([]int64, 1000000)
	for i := range arr {
		arr[i] = int64(i)
	}

	var total int64
	for _, v := range arr {
		total += v
	}
	fmt.Println(total)
}
