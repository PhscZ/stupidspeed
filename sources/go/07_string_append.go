// task 07 string_append — expected output: 1000000
// build: go build -o prog 07_string_append.go    run: ./prog
// build (tinygo): tinygo build -o prog.exe 07_string_append.go    run: ./prog.exe
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import "fmt"

func main() {
	text := ""
	for i := 0; i < 1000000; i++ {
		text += "x"
	}
	fmt.Println(len(text))
}
