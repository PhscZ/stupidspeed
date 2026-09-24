// task 11 parallel_sum — expected output: 7500000075000000
// build: odin build 11_parallel_sum.odin -o:speed -out:prog    run: ./prog
package main

import "core:fmt"
import "core:thread"

WORK :: 25_000_000
THREADS :: 4

Worker :: struct {
	t:     int,
	total: i64,
}

worker :: proc(th: ^thread.Thread) {
	w := cast(^Worker)th.data
	lo := i64(w.t) * WORK
	hi := lo + WORK
	acc: i64
	for i in lo ..< hi {
		switch i % 4 {
		case 0:
			acc += 1
		case 1:
			acc += i
		case 2:
			acc += 2 * i
		case 3:
			acc += 3 * i
		}
	}
	w.total = acc
}

main :: proc() {
	workers: [THREADS]Worker
	threads: [THREADS]^thread.Thread

	// core:thread creates a suspended thread; set its data, then start it
	for t in 0 ..< THREADS {
		workers[t].t = t
		th := thread.create(worker)
		th.data = rawptr(&workers[t])
		threads[t] = th
		thread.start(th)
	}

	total: i64
	for t in 0 ..< THREADS {
		thread.join(threads[t])
		total += workers[t].total
		thread.destroy(threads[t])
	}

	fmt.println(total)
}
