// task 05 alloc_churn — expected output: 1274991808
// build: go build -o prog 05_alloc_churn.go    run: ./prog
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import "fmt"

func main() {
	var slots [256][]byte
	var total uint64
	for i := 0; i < 10000000; i++ {
		buf := make([]byte, 64)
		buf[0] = byte(i % 256)
		total += uint64(buf[0])
		slots[i%256] = buf
	}
	fmt.Println(total)
}
