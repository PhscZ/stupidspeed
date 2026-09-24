// task 10 pi — expected output: 44889
// build: odin build . -o:speed    run: ./main
// core has no big integers, so this is Gibbons' unbounded spigot on hand-written
// sign-magnitude base-1e9 limbs: multiply by a small integer, divide by a big one
// (the quotient is a single digit, found by binary search), add, subtract, compare.
package main

import "core:fmt"

BASE :: 1_000_000_000
BASE_U :: u64(BASE)
DIGITS :: 10_000

Big :: struct {
	neg: bool,          // sign; never set while the value is zero
	d:   [dynamic]u64,  // little-endian limbs in [0, BASE), no leading zero limb
}

big_from_small :: proc(v: u64) -> Big {
	b: Big
	x := v
	for x > 0 {
		append(&b.d, x % BASE_U)
		x /= BASE_U
	}
	return b
}

big_clone :: proc(a: ^Big) -> Big {
	b: Big
	if len(a.d) > 0 {
		b.neg = a.neg
		b.d = make([dynamic]u64, len(a.d))
		copy(b.d[:], a.d[:])
	}
	return b
}

big_free :: proc(a: ^Big) {
	if a.d != nil {
		delete(a.d)
	}
	a.d = nil
	a.neg = false
}

big_trim :: proc(a: ^Big) {
	for len(a.d) > 0 && a.d[len(a.d) - 1] == 0 {
		pop(&a.d)
	}
	if len(a.d) == 0 {
		a.neg = false
	}
}

big_mag_cmp :: proc(a, b: ^Big) -> int {
	if len(a.d) != len(b.d) {
		if len(a.d) < len(b.d) {
			return -1
		}
		return 1
	}
	for i := len(a.d) - 1; i >= 0; i -= 1 {
		if a.d[i] != b.d[i] {
			if a.d[i] < b.d[i] {
				return -1
			}
			return 1
		}
	}
	return 0
}

big_mag_add :: proc(a, b: ^Big) -> Big {
	n := max(len(a.d), len(b.d))
	r := Big{d = make([dynamic]u64, n)}
	carry: u64 = 0
	for i in 0 ..< n {
		v := carry
		if i < len(a.d) {
			v += a.d[i]
		}
		if i < len(b.d) {
			v += b.d[i]
		}
		if v >= BASE_U {
			r.d[i] = v - BASE_U
			carry = 1
		} else {
			r.d[i] = v
			carry = 0
		}
	}
	if carry != 0 {
		append(&r.d, carry)
	}
	return r
}

big_mag_sub :: proc(a, b: ^Big) -> Big {
	r := Big{d = make([dynamic]u64, len(a.d))}
	borrow: u64 = 0
	for i in 0 ..< len(a.d) {
		av := a.d[i]
		bv: u64 = 0
		if i < len(b.d) {
			bv = b.d[i]
		}
		if av >= bv + borrow {
			r.d[i] = av - bv - borrow
			borrow = 0
		} else {
			r.d[i] = av + BASE_U - bv - borrow
			borrow = 1
		}
	}
	big_trim(&r)
	return r
}

// |a| * m, with m < 2^20 so limb*m + carry stays far inside a u64
big_mag_mul_small :: proc(a: ^Big, m: u64) -> Big {
	r := Big{d = make([dynamic]u64, len(a.d))}
	carry: u64 = 0
	for i in 0 ..< len(a.d) {
		v := a.d[i] * m + carry
		r.d[i] = v % BASE_U
		carry = v / BASE_U
	}
	for carry > 0 {
		append(&r.d, carry % BASE_U)
		carry /= BASE_U
	}
	big_trim(&r)
	return r
}

// |a| / |b| with |b| > 0, the quotient assumed to fit in a u64.
// The spigot only ever asks for a single-digit quotient, so an upper bound taken from the
// top two limbs gives a short binary search that needs nothing but small multiplication
// and comparison.
big_mag_divmod :: proc(a, b: ^Big) -> (q: u64, rem: Big) {
	if len(a.d) == 0 {
		return 0, Big{}
	}
	if big_mag_cmp(a, b) < 0 {
		return 0, big_clone(a)
	}
	n := len(a.d)
	m := len(b.d)
	top2 := a.d[n - 1]
	if n >= 2 {
		top2 = a.d[n - 1] * BASE_U + a.d[n - 2]
	}
	ub := (top2 + 1) / b.d[m - 1] + 1
	if ub > (1 << 20) {
		ub = 1 << 20
	}
	lo: u64 = 0
	hi: u64 = ub
	for lo < hi {
		mid := lo + (hi - lo + 1) / 2
		p := big_mag_mul_small(b, mid)
		c := big_mag_cmp(&p, a)
		big_free(&p)
		if c <= 0 {
			lo = mid
		} else {
			hi = mid - 1
		}
	}
	q = lo
	p := big_mag_mul_small(b, q)
	rem = big_mag_sub(a, &p)
	big_free(&p)
	// not reached for this program's digits, but keeps the result exact if the bound
	// above ever underestimates the quotient
	for big_mag_cmp(&rem, b) >= 0 {
		t := big_mag_sub(&rem, b)
		big_free(&rem)
		rem = t
		q += 1
	}
	return
}

big_neg :: proc(a: ^Big) -> Big {
	r := big_clone(a)
	if len(r.d) > 0 {
		r.neg = !r.neg
	}
	return r
}

big_add :: proc(a, b: ^Big) -> Big {
	if a.neg == b.neg {
		r := big_mag_add(a, b)
		if len(r.d) > 0 {
			r.neg = a.neg
		}
		return r
	}
	c := big_mag_cmp(a, b)
	if c == 0 {
		return Big{}
	}
	if c > 0 {
		r := big_mag_sub(a, b)
		r.neg = a.neg
		return r
	}
	r := big_mag_sub(b, a)
	r.neg = b.neg
	return r
}

big_sub :: proc(a, b: ^Big) -> Big {
	nb := big_neg(b)
	r := big_add(a, &nb)
	big_free(&nb)
	return r
}

big_mul_small :: proc(a: ^Big, m: u64) -> Big {
	if m == 0 || len(a.d) == 0 {
		return Big{}
	}
	r := big_mag_mul_small(a, m)
	r.neg = a.neg
	return r
}

big_cmp :: proc(a, b: ^Big) -> int {
	if a.neg != b.neg {
		if a.neg {
			return -1
		}
		return 1
	}
	c := big_mag_cmp(a, b)
	if a.neg {
		return -c
	}
	return c
}

// floor(a / b) with b > 0: i64 quotient plus a remainder in [0, b)
big_divmod_floor :: proc(a, b: ^Big) -> (q: i64, rem: Big) {
	if len(a.d) == 0 {
		return 0, Big{}
	}
	mag := Big{d = a.d} // the magnitude of a, read only
	qq, r := big_mag_divmod(&mag, b)
	if a.neg && len(r.d) > 0 {
		nr := big_mag_sub(b, &r)
		big_free(&r)
		return -i64(qq) - 1, nr
	}
	if a.neg {
		return -i64(qq), r
	}
	return i64(qq), r
}

main :: proc() {
	q := big_from_small(1)
	r := big_from_small(0)
	t := big_from_small(1)
	k: u64 = 1
	n: u64 = 3
	l: u64 = 3

	sum: u64
	count := 0
	for count < DIGITS {
		nt := big_mul_small(&t, n)

		// emit n when 4*q + r - t < n*t
		t4 := big_mul_small(&q, 4)
		s1 := big_add(&t4, &r)
		big_free(&t4)
		s2 := big_sub(&s1, &t)
		big_free(&s1)
		emit := big_cmp(&s2, &nt) < 0
		big_free(&s2)

		if emit {
			sum += n
			count += 1

			// next candidate from the old state: (10*(3*q + r))/t - 10*n
			t3 := big_mul_small(&q, 3)
			s3 := big_add(&t3, &r)
			big_free(&t3)
			s10 := big_mul_small(&s3, 10)
			big_free(&s3)
			qq, rm := big_divmod_floor(&s10, &t)
			big_free(&s10)
			big_free(&rm)
			nn := qq - 10 * i64(n)

			// q, r, t, k, n, l := 10*q, 10*(r - n*t), t, k, nn, l
			nq := big_mul_small(&q, 10)
			d := big_sub(&r, &nt)
			nr := big_mul_small(&d, 10)
			big_free(&d)
			big_free(&q)
			q = nq
			big_free(&r)
			r = nr
			n = u64(nn)
		} else {
			// next candidate from the old state: (q*(7*k + 2) + r*l)/(t*l)
			p1 := big_mul_small(&q, 7 * k + 2)
			rl := big_mul_small(&r, l)
			s := big_add(&p1, &rl)
			big_free(&p1)
			big_free(&rl)
			tl := big_mul_small(&t, l)
			qq, rm := big_divmod_floor(&s, &tl)
			big_free(&s)
			big_free(&tl)
			big_free(&rm)
			nn := qq

			// q, r, t, k, n, l := q*k, (2*q + r)*l, t*l, k+1, nn, l+2
			nq := big_mul_small(&q, k)
			q2 := big_mul_small(&q, 2)
			s2 := big_add(&q2, &r)
			big_free(&q2)
			nr := big_mul_small(&s2, l)
			big_free(&s2)
			nt2 := big_mul_small(&t, l)
			big_free(&q)
			q = nq
			big_free(&r)
			r = nr
			big_free(&t)
			t = nt2
			k += 1
			n = u64(nn)
			l += 2
		}

		big_free(&nt)
	}

	fmt.println(sum)

	big_free(&q)
	big_free(&r)
	big_free(&t)
}
