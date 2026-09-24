// task 04 array_sum — expected output: 499999500000
// build: go build -o prog 04_array_sum.go    run: ./prog
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import "fmt"

func main() {
	arr := make([]int64, 1000000)
	for i := 0; i < 1000000; i++ {
		arr[i] = int64(i)
	}

	var total int64
	for i := 0; i < 1000000; i++ {
		total += arr[i]
	}
	fmt.Println(total)
}
