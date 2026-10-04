// task 10 pi — expected output: 4470
// build: tools/beef/bin/BeefBuild.exe -proddir=sources/beef/10_pi -config=Release -platform=Win64
// run:   sources/beef/10_pi/out/prog.exe
// note: Beef builds projects rather than single files, so every task is a directory holding
//       this source plus a two-file wrapper (BeefProj.toml, BeefSpace.toml) that lists it.
// note: corlib has no big-integer type (System.Numerics holds only SIMD vectors), so this is
//       the hand-rolled version the task's rules describe: sign-magnitude, little-endian
//       base-1e9 limbs, add/subtract/multiply-by-a-small-integer/quotient-by-repeated-
//       subtraction, the same algorithm and the same limb order as sources/c/10_pi.c.
// note: limbs are `uint64`, so a limb product plus carry stays inside 64 bits with the same
//       headroom argument the C row makes; no 128-bit arithmetic is used anywhere.
// note: literals above 2^31 need an `L` suffix in Beef, so the base is written 1000000000L.

using System;
using System.Collections;
using System.Diagnostics;

namespace Task;

class Big
{
	public const uint64 Base = 1000000000L;

	public List<uint64> mLimb = new .() ~ delete _;
	public int64 mN;      // limb count, no leading zero limbs
	public bool mNeg;

	public void Reserve(int64 need)
	{
		if (need > mLimb.Count)
			mLimb.Resize((int)need);
	}

	public void Trim()
	{
		while ((mN > 0) && (mLimb[mN - 1] == 0))
			mN--;
		if (mN == 0)
			mNeg = false;
	}

	public void Set(uint64 value)
	{
		uint64 v = value;
		mN = 0;
		mNeg = false;
		while (v > 0)
		{
			Reserve(mN + 1);
			mLimb[mN++] = v % Base;
			v /= Base;
		}
	}

	public void Copy(Big src)
	{
		Reserve(src.mN);
		for (int64 i = 0; i < src.mN; i++)
			mLimb[i] = src.mLimb[i];
		mN = src.mN;
		mNeg = src.mNeg;
	}

	public static int CmpMag(Big a, Big b)
	{
		if (a.mN != b.mN)
			return a.mN < b.mN ? -1 : 1;
		for (int64 i = a.mN; i-- > 0; )
		{
			if (a.mLimb[i] != b.mLimb[i])
				return a.mLimb[i] < b.mLimb[i] ? -1 : 1;
		}
		return 0;
	}

	public static int Cmp(Big a, Big b)
	{
		if (a.mNeg != b.mNeg)
			return a.mNeg ? -1 : 1;
		int c = CmpMag(a, b);
		return a.mNeg ? -c : c;
	}

	public static void AddMag(Big r, Big a, Big b)
	{
		int64 n = a.mN > b.mN ? a.mN : b.mN;
		r.Reserve(n + 1);
		uint64 carry = 0;
		for (int64 i = 0; i < n; i++)
		{
			uint64 s = carry;
			if (i < a.mN)
				s += a.mLimb[i];
			if (i < b.mN)
				s += b.mLimb[i];
			if (s >= Base)
			{
				s -= Base;
				carry = 1;
			}
			else
				carry = 0;
			r.mLimb[i] = s;
		}
		r.mLimb[n] = carry;
		r.mN = n + (carry != 0 ? 1 : 0);
		r.mNeg = false;
	}

	public static void SubMag(Big r, Big a, Big b)   // requires a >= b >= 0
	{
		r.Reserve(a.mN);
		uint64 borrow = 0;
		for (int64 i = 0; i < a.mN; i++)
		{
			uint64 bi = (i < b.mN ? b.mLimb[i] : 0) + borrow;
			if (a.mLimb[i] >= bi)
			{
				r.mLimb[i] = a.mLimb[i] - bi;
				borrow = 0;
			}
			else
			{
				r.mLimb[i] = a.mLimb[i] + Base - bi;
				borrow = 1;
			}
		}
		r.mN = a.mN;
		r.mNeg = false;
		r.Trim();
	}

	public static void Add(Big r, Big a, Big b)
	{
		bool an = a.mNeg, bn = b.mNeg;
		if (an == bn)
		{
			AddMag(r, a, b);
			r.mNeg = an;
		}
		else if (CmpMag(a, b) >= 0)
		{
			SubMag(r, a, b);
			r.mNeg = an;
		}
		else
		{
			SubMag(r, b, a);
			r.mNeg = bn;
		}
		r.Trim();
	}

	public static void Sub(Big r, Big a, Big b)      // r = a - b
	{
		bool an = a.mNeg, bn = b.mNeg;
		if (an != bn)
		{
			AddMag(r, a, b);
			r.mNeg = an;
		}
		else if (CmpMag(a, b) >= 0)
		{
			SubMag(r, a, b);
			r.mNeg = an;
		}
		else
		{
			SubMag(r, b, a);
			r.mNeg = !an;
		}
		r.Trim();
	}

	public static void MulSmall(Big r, Big a, uint64 m)
	{
		if ((m == 0) || (a.mN == 0))
		{
			r.mN = 0;
			r.mNeg = false;
			return;
		}
		r.Reserve(a.mN + 2);
		uint64 carry = 0;
		for (int64 i = 0; i < a.mN; i++)
		{
			uint64 p = a.mLimb[i] * m + carry;
			r.mLimb[i] = p % Base;
			carry = p / Base;
		}
		int64 n = a.mN;
		while (carry > 0)
		{
			r.mLimb[n++] = carry % Base;
			carry /= Base;
		}
		r.mN = n;
		r.mNeg = a.mNeg;
		r.Trim();
	}

	// floor(a / b) for a >= 0 and b > 0. The spigot only ever asks for a quotient of one
	// decimal digit, so counting how many times b fits into a is enough.
	public static uint64 Quot(Big a, Big b, Big work)
	{
		uint64 q = 0;
		if (a.mNeg || b.mNeg || b.mN == 0)
			return 0;
		work.Copy(b);
		while (Cmp(a, work) >= 0)
		{
			q++;
			AddMag(work, work, b);
		}
		return q;
	}
}

class Program
{
	static void Main()
	{
		// timing: Stopwatch.GetTimestamp() is corlib's microsecond clock (QueryPerformanceCounter on Windows).
		int64 t0 = Stopwatch.GetTimestamp();

		Big q = new Big();
		Big r = new Big();
		Big t = new Big();
		Big u = new Big();
		Big v = new Big();
		Big w = new Big();

		q.Set(1);
		r.Set(0);
		t.Set(1);

		uint64 k = 1, l = 3, n = 3;
		uint64 sum = 0;

		for (int64 produced = 0; produced < 1000; )
		{
			Big.MulSmall(u, q, 4);
			Big.Add(u, u, r);                  // u = 4q + r
			Big.MulSmall(v, t, n + 1);         // v = (n + 1)t

			if (Big.Cmp(u, v) < 0)
			{
				// the digit n is settled
				sum += n;
				produced++;

				Big.MulSmall(u, q, 3);
				Big.Add(u, u, r);
				Big.MulSmall(u, u, 10);        // u = 10(3q + r)
				uint64 next = Big.Quot(u, t, w) - 10 * n;

				Big.MulSmall(v, t, n);         // v = n t
				Big.Sub(v, r, v);              // v = r - n t
				Big.MulSmall(r, v, 10);        // r = 10(r - n t)
				Big.MulSmall(q, q, 10);        // q = 10q, t is unchanged

				n = next;
			}
			else
			{
				// not settled yet: widen the state by one more term
				Big.MulSmall(u, q, 7 * k + 2);
				Big.MulSmall(v, r, l);
				Big.Add(u, u, v);              // u = q(7k + 2) + r l
				Big.MulSmall(v, t, l);         // v = t l
				uint64 next = Big.Quot(u, v, w);

				Big.MulSmall(u, q, 2);
				Big.Add(u, u, r);
				Big.MulSmall(u, u, l);         // u = (2q + r) l
				r.Copy(u);
				Big.MulSmall(q, q, k);
				Big.MulSmall(t, t, l);

				k++;
				l += 2;
				n = next;
			}
		}

		int64 t1 = Stopwatch.GetTimestamp();
		Console.Error.WriteLine($"TIME_MS={(double)(t1 - t0) / 1000.0}");
		Console.WriteLine("{0}", sum);

		delete q;
		delete r;
		delete t;
		delete u;
		delete v;
		delete w;
	}
}
