// task 11 parallel_sum — expected output: 7500000075000000
// build: v -prod -cc gcc -o prog 11_parallel_sum.v    run: ./prog
// note: four `spawn` threads, one fixed 25000000-wide range each, so which thread
//       finishes first cannot change the answer. `handles.wait()` joins them and
//       returns the four results in spawn order.

module main

const span = i64(25000000)

fn work(t i64) i64 {
	mut acc := i64(0)
	lo := t * span
	hi := lo + span

	for i := lo; i < hi; i++ {
		match i % 4 {
			0 { acc += 1 }
			1 { acc += i }
			2 { acc += 2 * i }
			3 { acc += 3 * i }
			else {}
		}
	}
	return acc
}

fn main() {
	mut handles := []thread i64{}
	for t in 0 .. 4 {
		handles << spawn work(i64(t))
	}

	results := handles.wait()

	mut total := i64(0)
	for acc in results {
		total += acc
	}

	println(total)
}
