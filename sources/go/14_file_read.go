// task 14 file_read — expected output: 484442112
// build: go build -o prog 14_file_read.go    run: ./prog
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import (
	"fmt"
	"io"
	"os"
)

func main() {
	f, err := os.Open("data.bin")
	if err != nil {
		panic(err)
	}
	defer f.Close()

	buf := make([]byte, 1<<20)
	var total uint64
	for {
		n, err := f.Read(buf)
		for i := 0; i < n; i++ {
			total += uint64(buf[i])
		}
		if err == io.EOF {
			break
		}
		if err != nil {
			panic(err)
		}
	}
	fmt.Println(total % 4294967296)
}
