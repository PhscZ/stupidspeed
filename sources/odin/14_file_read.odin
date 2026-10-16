// task 14 file_read — expected output: 1937768448
// build: odin build 14_file_read.odin -o:speed -out:prog    run: ./prog
// note: data.bin is read in 1 MiB chunks, eight times over, reopened at the start of each pass.
package main

import "core:fmt"
import "core:os"
import "core:time"

main :: proc() {
	t0 := time.now()

	buf := make([]u8, 1 << 20)
	defer delete(buf)

	total: u64
	for pass := 0; pass < 8; pass += 1 {
		f, err := os.open("data.bin")
		if err != nil {
			os.exit(1)
		}

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
		os.close(f)
	}
	fmt.eprintfln("TIME_MS=%.3f", time.duration_milliseconds(time.since(t0)))
	fmt.println(total % 4294967296)
}
