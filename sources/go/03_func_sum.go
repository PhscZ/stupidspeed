// task 03 func_sum — expected output: 100000000
// build: go build -o prog 03_func_sum.go    run: ./prog
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import "fmt"

//go:noinline
func addOne(n uint64) uint64 {
	return n + 1
}

func main() {
	var value uint64
	for i := 0; i < 100000000; i++ {
		value = addOne(value)
	}
	fmt.Println(value)
}
