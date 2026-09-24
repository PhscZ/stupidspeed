// task 08 average — expected output: 0.498046875
// build: odin build . -o:speed    run: ./main
package main

import "core:fmt"

main :: proc() {
	total: f64 = 0.0
	for i in 0 ..< 100_000_000 {
		reading := f64(i % 256) / 256.0
		total += reading
	}
	avg := total / 100_000_000.0
	// the total is exact in binary, so 9 digits after the point print the value exactly
	fmt.printfln("%.9f", avg)
}
