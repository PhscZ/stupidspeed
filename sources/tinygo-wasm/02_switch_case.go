// task 02 switch_case — expected output: 7500000075000000
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 02_switch_case.go    run: tools/wasmtime46/wasmtime.exe prog.wasm
// note: the build needs tools/tinygo/bin/wasm-opt.exe (binaryen) beside tinygo.exe — the TinyGo
//       release zip ships no wasm-opt, and every wasm target runs it.
package main

import "fmt"

func main() {
	var acc uint64
	for i := range uint64(100000000) {
		switch i % 4 {
		case 0:
			acc += 1
		case 1:
			acc += i
		case 2:
			acc += 2 * i
		case 3:
			acc += 3 * i
		}
	}
	fmt.Println(acc)
}
