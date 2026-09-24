// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: go build -o prog 01_branches.go    run: ./prog
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import "fmt"

func main() {
	var a, b, c, d uint64
	for i := uint64(0); i < 100000000; i++ {
		if i%3 == 0 {
			a++
		} else if i%5 == 0 {
			b++
		} else if i%7 == 0 {
			c++
		} else {
			d++
		}
	}
	fmt.Println(a, b, c, d)
}
