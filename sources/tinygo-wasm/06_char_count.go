// task 06 char_count — expected output: 10000000
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 06_char_count.go    run: tools/wasmtime46/wasmtime.exe prog.wasm
// note: the 100 MB string is built by strings.Repeat, not appended in a loop, so the build is
//       not part of the measurement.
// note: the build needs tools/tinygo/bin/wasm-opt.exe (binaryen) beside tinygo.exe — the TinyGo
//       release zip ships no wasm-opt, and every wasm target runs it.
package main

import (
	"fmt"
	"strings"
)

func main() {
	text := strings.Repeat("abcdefghij", 10000000)

	count := 0
	for i := range text {
		if text[i] == 'h' {
			count++
		}
	}
	fmt.Println(count)
}
