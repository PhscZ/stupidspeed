// task 15 file_write — expected output: 104857600
// build: go build -o prog main.go    run: ./prog
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import (
	"fmt"
	"os"
)

func main() {
	buf := make([]byte, 1<<20)
	for i := range buf {
		buf[i] = byte(i % 256)
	}

	f, err := os.Create("out.bin")
	if err != nil {
		panic(err)
	}

	written := 0
	for i := 0; i < 100; i++ {
		n, err := f.Write(buf)
		if err != nil {
			panic(err)
		}
		written += n
	}

	if err := f.Sync(); err != nil {
		panic(err)
	}
	if err := f.Close(); err != nil {
		panic(err)
	}
	fmt.Println(written)
}
