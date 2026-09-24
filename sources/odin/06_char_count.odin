// task 06 char_count — expected output: 10000000
// build: odin build 06_char_count.odin -o:speed -out:prog    run: ./prog
package main

import "core:fmt"
import "core:strings"

main :: proc() {
	REPEATS :: 10_000_000

	// the whole 100 MB text is built in one bulk repeat call
	text := strings.repeat("abcdefghij", REPEATS)
	defer delete(text)

	count: i64
	for i in 0 ..< len(text) {
		ch := text[i]
		if ch == 'a' {
			continue
		} else if ch == 'e' {
			continue
		} else if ch == 'h' {
			count += 1
		} else {
			continue
		}
	}
	fmt.println(count)
}
