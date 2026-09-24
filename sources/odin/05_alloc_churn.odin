// task 05 alloc_churn — expected output: 1274991808
// build: odin build 05_alloc_churn.odin -o:speed -out:prog    run: ./prog
package main

import "core:fmt"

main :: proc() {
	slots: [256]^[64]u8
	total: i64
	for i in 0 ..< 10_000_000 {
		buf := new([64]u8)
		buf[0] = u8(i % 256)
		total += i64(buf[0])
		idx := i % 256
		if slots[idx] != nil {
			free(slots[idx])
		}
		slots[idx] = buf
	}
	fmt.println(total)
}
