// task 15 file_write — expected output: 104857600
// build: v -prod -cc gcc -o prog 15_file_write.v    run: ./prog
// note: the 1 MiB buffer is written 100 times through the os.File buffer, then
//       flushed and committed. `os` has no fsync wrapper, so the commit goes to the
//       C library directly: _commit on Windows, fsync everywhere else.

module main

import os

const chunk = 1048576

#include <io.h>
#include <unistd.h>

fn C._commit(fd int) int
fn C.fsync(fd int) int

fn commit(fd int) {
	$if windows {
		C._commit(fd)
	} $else {
		C.fsync(fd)
	}
}

fn main() {
	mut buf := []u8{len: chunk}
	for i in 0 .. chunk {
		buf[i] = u8(i % 256)
	}

	mut f := os.create('out.bin') or { panic(err) }

	mut written := i64(0)
	for _ in 0 .. 100 {
		n := f.write(buf) or { panic(err) }
		written += i64(n)
	}

	f.flush()
	commit(f.fd)
	f.close()

	println(written)
}
