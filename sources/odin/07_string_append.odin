// task 07 string_append — expected output: 1000000
// build: odin build 07_string_append.odin -o:speed -out:prog    run: ./prog
// Odin strings are immutable, so `text = text + "x"` allocates a fresh string, copies the
// old one and drops it; that is what make/copy/delete below does each iteration.
package main

import "core:fmt"

main :: proc() {
	text: []u8 = nil
	for _ in 0 ..< 1_000_000 {
		n := len(text)
		next := make([]u8, n + 1)
		copy(next, text)
		next[n] = u8('x')
		if text != nil {
			delete(text)
		}
		text = next
	}
	fmt.println(len(text))
}
