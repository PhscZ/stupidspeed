// task 02 switch_case — expected output: 7500000075000000
// build: go build -o prog 02_switch_case.go    run: ./prog
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import "fmt"

func main() {
	var acc uint64
	for i := uint64(0); i < 100000000; i++ {
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
