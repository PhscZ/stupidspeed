// task 07 string_append — expected output: 250000
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 07_string_append.go    run: tools/wasmtime46/wasmtime.exe prog.wasm
// note: the append is a copy, so this cell is honestly quadratic and is the slowest in the row.
// note: the build needs tools/tinygo/bin/wasm-opt.exe (binaryen) beside tinygo.exe — the TinyGo
//       release zip ships no wasm-opt, and every wasm target runs it.
package main

import "fmt"

func main() {
	text := ""
	for range 250000 {
		text += "x"
	}
	fmt.Println(len(text))
}
