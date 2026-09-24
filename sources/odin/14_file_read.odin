// task 14 file_read — expected output: 484442112
// build: odin build 14_file_read.odin -o:speed -out:prog    run: ./prog
package main

import "core:fmt"
import "core:os"

main :: proc() {
	f, err := os.open("data.bin")
	if err != nil {
		os.exit(1)
	}
	defer os.close(f)

	buf := make([]u8, 1 << 20)
	defer delete(buf)

	total: u64
	for {
		n, rerr := os.read(f, buf)
		if n > 0 {
			for i in 0 ..< n {
				total += u64(buf[i])
			}
		}
		if n == 0 || rerr != nil {
			break
		}
	}
	fmt.println(total % 4294967296)
}
