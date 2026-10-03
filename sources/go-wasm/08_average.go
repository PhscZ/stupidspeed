// task 08 average — expected output: 0.498046875
// build: go build -o prog 08_average.go    run: ./prog
// build (tinygo): tinygo build -o prog.exe 08_average.go    run: ./prog.exe
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import "fmt"

func main() {
	total := 0.0
	for i := uint64(0); i < 100000000; i++ {
		reading := float64(i%256) / 256.0
		total += reading
	}
	average := total / 100000000
	fmt.Printf("%.9f\n", average)
}
