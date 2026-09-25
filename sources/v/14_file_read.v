// task 14 file_read — expected output: 484442112
// build: v -prod -cc gcc -o prog 14_file_read.v    run: ./prog
// note: data.bin is read from the current directory in 1 MiB chunks and every byte is
//       added up; the running total is reduced mod 2^32 only when it is printed.

module main

import os

const chunk = 1048576

fn main() {
	mut f := os.open('data.bin') or { panic(err) }

	mut buf := []u8{len: chunk}
	mut total := u64(0)

	for {
		got := f.read(mut buf) or { break }
		if got == 0 {
			break
		}
		for i in 0 .. got {
			total += u64(buf[i])
		}
	}

	f.close()

	println(total % 4294967296)
}
