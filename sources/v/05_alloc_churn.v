// task 05 alloc_churn — expected output: 1274991808
// build: v -prod -cc gcc -o prog 05_alloc_churn.v    run: ./prog
// note: `[]u8{len: 64}` is the V allocation primitive: -prod builds use the Boehm
//       collector, so the 64-byte buffers are collected garbage once the slot that
//       held them is overwritten. Storing into `slots` is what keeps them reachable.

module main

fn main() {
	mut slots := [][]u8{len: 256}
	mut total := i64(0)

	for i in 0 .. 10000000 {
		mut buf := []u8{len: 64}
		buf[0] = u8(i % 256)
		total += i64(buf[0])
		slots[i % 256] = buf
	}

	println(total)
}
