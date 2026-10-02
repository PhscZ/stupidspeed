// task 11 parallel_sum — expected output: 7500000075000000
// build: tools/tinygo/bin/tinygo.exe build -target=wasip1 -o prog.wasm 11_parallel_sum.go    run: tools/wasmtime46/wasmtime.exe prog.wasm
// note: correct-answer-no-speedup. Go's wasip1 port has no thread support, so the four goroutines
//       are multiplexed onto the single wasm thread by TinyGo's asyncify scheduler (the wasip1
//       target default): the quarters are correct but serial, the same disposition as CPython,
//       CRuby and Simul.
// note: the build needs tools/tinygo/bin/wasm-opt.exe (binaryen) beside tinygo.exe — the TinyGo
//       release zip ships no wasm-opt, and every wasm target runs it.
package main

import (
	"fmt"
	"sync"
)

// work does task 02's switch over one fixed quarter of the range.
func work(t uint64) uint64 {
	var acc uint64
	lo := t * 25000000
	hi := (t + 1) * 25000000
	for i := lo; i < hi; i++ {
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
	return acc
}

func main() {
	partials := make([]uint64, 4)
	var wg sync.WaitGroup
	for t := range uint64(4) {
		wg.Add(1)
		go func(t uint64) {
			defer wg.Done()
			partials[t] = work(t)
		}(t)
	}
	wg.Wait()

	var total uint64
	for _, p := range partials {
		total += p
	}
	fmt.Println(total)
}
