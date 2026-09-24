// task 11 parallel_sum — expected output: 7500000075000000
// build: go build -o prog main.go    run: ./prog
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
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
	for t := uint64(0); t < 4; t++ {
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
