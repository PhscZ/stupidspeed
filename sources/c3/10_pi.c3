// task 10 pi — expected output: 4470
// build: c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc-lib> -L <ucrt-lib> -L <um-lib> -o prog 10_pi.c3    run: prog.exe
// note: <sdk> is the MSVC tree's "Windows Kits\10", <vc-lib> its
//       VC\Tools\MSVC\<version>\lib\x64, and <ucrt-lib> and <um-lib> the SDK's
//       Lib\<sdk-version>\ucrt\x64 and Lib\<sdk-version>\um\x64. Those are what the
//       LLVM backend links against; without them c3c tries to download an SDK of its own.
//       -O2 is the optimisation flag, and c3c defaults to -O0.
// note: --wincrt=dynamic links against the system ucrtbase.dll and vcruntime140.dll, so
//       the executable needs no extra runtime DLLs beside it.
// note: std::math::bigint is fixed at 8192 bits, about 2466 decimal digits, so it cannot
//       hold 1000 digits of pi. The state is therefore hand-written big integers, the
//       same sign-magnitude base-1e9 little-endian limbs as sources/c/10_pi.c, with only
//       the operations the spigot needs: add, subtract, multiply by a small integer, and
//       a quotient that is always one decimal digit and so comes out of repeated
//       subtraction. No 128-bit arithmetic is used. Only the digit sum is printed.

module c3_10_pi;
import std::io;
import std::core::mem;
import std::time::clock;

const ulong BASE = 1000000000;

struct Big
{
	ulong* limb;   // little-endian, base 1e9
	usz n;         // limb count, no leading zero limbs
	usz cap;
	int neg;
}

fn void big_init(Big* x)
{
	x.n = 0;
	x.cap = 8;
	x.neg = 0;
	x.limb = (ulong*)mem::malloc((sz)(x.cap * ulong::size));
}

fn void big_free(Big* x)
{
	mem::free(x.limb);
	x.limb = null;
}

fn void big_reserve(Big* x, usz need)
{
	if (need <= x.cap)
	{
		return;
	}
	while (x.cap < need)
	{
		x.cap *= 2;
	}
	x.limb = (ulong*)mem::realloc(x.limb, (sz)(x.cap * ulong::size));
}

fn void big_trim(Big* x)
{
	while (x.n > 0 && x.limb[x.n - 1] == 0)
	{
		x.n--;
	}
	if (x.n == 0)
	{
		x.neg = 0;
	}
}

fn void big_set(Big* x, ulong v)
{
	x.n = 0;
	x.neg = 0;
	while (v > 0)
	{
		big_reserve(x, x.n + 1);
		x.limb[x.n++] = v % BASE;
		v /= BASE;
	}
}

fn void big_copy(Big* dst, Big* src)
{
	big_reserve(dst, src.n);
	if (src.n > 0)
	{
		mem::copy(dst.limb, src.limb, (sz)(src.n * ulong::size));
	}
	dst.n = src.n;
	dst.neg = src.neg;
}

fn int big_cmp_mag(Big* a, Big* b)
{
	if (a.n != b.n)
	{
		return a.n < b.n ? -1 : 1;
	}
	usz i = a.n;
	while (i > 0)
	{
		i--;
		if (a.limb[i] != b.limb[i])
		{
			return a.limb[i] < b.limb[i] ? -1 : 1;
		}
	}
	return 0;
}

fn int big_cmp(Big* a, Big* b)
{
	if (a.neg != b.neg)
	{
		return a.neg ? -1 : 1;
	}
	int c = big_cmp_mag(a, b);
	return a.neg ? -c : c;
}

fn void big_add_mag(Big* r, Big* a, Big* b)
{
	usz n = a.n > b.n ? a.n : b.n;
	big_reserve(r, n + 1);
	ulong carry = 0;
	for (usz i = 0; i < n; i++)
	{
		ulong s = carry;
		if (i < a.n)
		{
			s += a.limb[i];
		}
		if (i < b.n)
		{
			s += b.limb[i];
		}
		if (s >= BASE)
		{
			s -= BASE;
			carry = 1;
		}
		else
		{
			carry = 0;
		}
		r.limb[i] = s;
	}
	r.limb[n] = carry;
	r.n = carry != 0 ? n + 1 : n;
	r.neg = 0;
}

// requires a >= b >= 0
fn void big_sub_mag(Big* r, Big* a, Big* b)
{
	big_reserve(r, a.n);
	ulong borrow = 0;
	for (usz i = 0; i < a.n; i++)
	{
		ulong bi = (i < b.n ? b.limb[i] : 0) + borrow;
		if (a.limb[i] >= bi)
		{
			r.limb[i] = a.limb[i] - bi;
			borrow = 0;
		}
		else
		{
			r.limb[i] = a.limb[i] + BASE - bi;
			borrow = 1;
		}
	}
	r.n = a.n;
	r.neg = 0;
	big_trim(r);
}

fn void big_add(Big* r, Big* a, Big* b)
{
	int an = a.neg;
	int bn = b.neg;
	if (an == bn)
	{
		big_add_mag(r, a, b);
		r.neg = an;
	}
	else if (big_cmp_mag(a, b) >= 0)
	{
		big_sub_mag(r, a, b);
		r.neg = an;
	}
	else
	{
		big_sub_mag(r, b, a);
		r.neg = bn;
	}
	big_trim(r);
}

// r = a - b
fn void big_sub(Big* r, Big* a, Big* b)
{
	int an = a.neg;
	int bn = b.neg;
	if (an != bn)
	{
		big_add_mag(r, a, b);
		r.neg = an;
	}
	else if (big_cmp_mag(a, b) >= 0)
	{
		big_sub_mag(r, a, b);
		r.neg = an;
	}
	else
	{
		big_sub_mag(r, b, a);
		r.neg = an ? 0 : 1;
	}
	big_trim(r);
}

fn void big_mul_small(Big* r, Big* a, ulong m)
{
	if (m == 0 || a.n == 0)
	{
		r.n = 0;
		r.neg = 0;
		return;
	}
	big_reserve(r, a.n + 2);
	ulong carry = 0;
	for (usz i = 0; i < a.n; i++)
	{
		ulong p = a.limb[i] * m + carry;
		r.limb[i] = p % BASE;
		carry = p / BASE;
	}
	usz n = a.n;
	while (carry > 0)
	{
		r.limb[n++] = carry % BASE;
		carry /= BASE;
	}
	r.n = n;
	r.neg = a.neg;
	big_trim(r);
}

// floor(a / b) for a >= 0 and b > 0. The spigot only ever asks for a quotient of one
// decimal digit, so counting how many times b fits into a is enough.
fn ulong big_quot(Big* a, Big* b, Big* work)
{
	ulong q = 0;
	if (a.neg || b.neg || b.n == 0)
	{
		return 0;
	}
	big_copy(work, b);
	while (big_cmp(a, work) >= 0)
	{
		q++;
		big_add_mag(work, work, b);
	}
	return q;
}

fn void main()
{
	Clock t0 = clock::now();
	Big q;
	Big r;
	Big t;
	Big u;
	Big v;
	Big w;
	big_init(&q);
	big_init(&r);
	big_init(&t);
	big_init(&u);
	big_init(&v);
	big_init(&w);

	big_set(&q, 1);
	big_set(&r, 0);
	big_set(&t, 1);

	ulong k = 1;
	ulong l = 3;
	ulong n = 3;
	ulong sum = 0;

	for (long produced = 0; produced < 1000; )
	{
		big_mul_small(&u, &q, 4);
		big_add(&u, &u, &r);              // u = 4q + r
		big_mul_small(&v, &t, n + 1);     // v = (n + 1)t

		if (big_cmp(&u, &v) < 0)
		{
			// the digit n is settled
			sum += n;
			produced++;

			big_mul_small(&u, &q, 3);
			big_add(&u, &u, &r);
			big_mul_small(&u, &u, 10);           // u = 10(3q + r)
			ulong next = big_quot(&u, &t, &w) - 10 * n;

			big_mul_small(&v, &t, n);            // v = n t
			big_sub(&v, &r, &v);                 // v = r - n t
			big_mul_small(&r, &v, 10);           // r = 10(r - n t)
			big_mul_small(&q, &q, 10);           // q = 10q, t is unchanged

			n = next;
		}
		else
		{
			// not settled yet: widen the state by one more term
			big_mul_small(&u, &q, 7 * k + 2);
			big_mul_small(&v, &r, l);
			big_add(&u, &u, &v);                 // u = q(7k + 2) + r l
			big_mul_small(&v, &t, l);            // v = t l
			ulong next = big_quot(&u, &v, &w);

			big_mul_small(&u, &q, 2);
			big_add(&u, &u, &r);
			big_mul_small(&u, &u, l);            // u = (2q + r) l
			big_copy(&r, &u);
			big_mul_small(&q, &q, k);
			big_mul_small(&t, &t, l);

			k++;
			l += 2;
			n = next;
		}
	}

	NanoDuration elapsed = clock::now() - t0;
	io::eprintfn("TIME_MS=%.3f", (double)elapsed / 1_000_000.0);
	io::printfn("%d", sum);

	big_free(&q);
	big_free(&r);
	big_free(&t);
	big_free(&u);
	big_free(&v);
	big_free(&w);
}
