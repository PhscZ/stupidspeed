// task 10 pi — expected output: 44889
// build: v -prod -cc gcc -o prog 10_pi.v    run: ./prog
// note: Gibbons' unbounded spigot. V has arbitrary-precision integers in the standard
//       library (`math.big`, the `Integer` type), so the spigot runs on those rather
//       than on hand-rolled limbs. Only the sum of the 10000 digits is printed.
// note: `Integer.int()` is only ever asked for a value below 10 here — the spigot's
//       quotient for the next digit is always a single decimal digit.

module main

import math.big

const digits = 10000

fn main() {
	mut q := big.integer_from_int(1)
	mut r := big.integer_from_int(0)
	mut t := big.integer_from_int(1)
	mut k := 1
	mut n := 3
	mut l := 3

	mut total := 0
	mut emitted := 0

	for emitted < digits {
		// the digit n is settled when 4*q + r - t < n * t
		if big.integer_from_int(4) * q + r - t < big.integer_from_int(n) * t {
			total += n
			emitted++
			oldq := q
			oldr := r
			q = oldq * big.integer_from_int(10)
			r = (oldr - big.integer_from_int(n) * t) * big.integer_from_int(10)
			n = (big.integer_from_int(10) * (big.integer_from_int(3) * oldq + oldr) / t).int() - 10 * n
		} else {
			oldq := q
			oldr := r
			tl := t * big.integer_from_int(l)
			n =
				((big.integer_from_int(7 * k + 2) * oldq + big.integer_from_int(l) * oldr) / tl).int()
			q = oldq * big.integer_from_int(k)
			r = (big.integer_from_int(2) * oldq + oldr) * big.integer_from_int(l)
			t = tl
			k++
			l += 2
		}
	}

	println(total)
}
