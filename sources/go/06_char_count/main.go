// task 06 char_count — expected output: 10000000
// build: go build -o prog main.go    run: ./prog
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import (
	"fmt"
	"strings"
)

func main() {
	text := strings.Repeat("abcdefghij", 10000000)

	count := 0
	for i := range text {
		if text[i] == 'h' {
			count++
		}
	}
	fmt.Println(count)
}
