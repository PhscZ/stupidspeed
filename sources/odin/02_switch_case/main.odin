// task 02 switch_case — expected output: 7500000075000000
// build: odin build . -o:speed    run: ./main
package main

import "core:fmt"

main :: proc() {
	acc: i64
	for i in 0 ..< 100_000_000 {
		switch i % 4 {
		case 0:
			acc += 1
		case 1:
			acc += i64(i)
		case 2:
			acc += 2 * i64(i)
		case 3:
			acc += 3 * i64(i)
		}
	}
	fmt.println(acc)
}
