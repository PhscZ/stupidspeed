// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: odin build 01_branches.odin -o:speed -out:prog    run: ./prog
package main

import "core:fmt"

main :: proc() {
	a, b, c, d: i64
	for i in 0 ..< 100_000_000 {
		if i % 3 == 0 {
			a += 1
		} else if i % 5 == 0 {
			b += 1
		} else if i % 7 == 0 {
			c += 1
		} else {
			d += 1
		}
	}
	fmt.println(a, b, c, d)
}
