// task 09 fib_recursive — expected output: 102334155
// build: go build -o prog main.go    run: ./prog
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import "fmt"

func fib(n int) int {
	if n < 2 {
		return n
	}
	return fib(n-1) + fib(n-2)
}

func main() {
	fmt.Println(fib(40))
}
