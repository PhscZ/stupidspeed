// task 15 file_write — expected output: 104857600
// build: odin build . -o:speed    run: ./main
// fsync is os.flush in core:os (FlushFileBuffers on Windows, fsync on Unix), and
// core:os has no os.create, so the file is opened with O_WRONLY|O_CREATE|O_TRUNC.
package main

import "core:fmt"
import "core:os"

main :: proc() {
	buf := make([]u8, 1 << 20)
	defer delete(buf)
	for i in 0 ..< len(buf) {
		buf[i] = u8(i % 256)
	}

	f, err := os.open("out.bin", os.O_WRONLY | os.O_CREATE | os.O_TRUNC, 0o666)
	if err != nil {
		os.exit(1)
	}

	written: i64
	for _ in 0 ..< 100 {
		n, werr := os.write(f, buf)
		written += i64(n)
		if werr != nil {
			break
		}
	}

	os.flush(f)
	os.close(f)
	fmt.println(written)
}
