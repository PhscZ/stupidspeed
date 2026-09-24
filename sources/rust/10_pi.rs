// task 10 pi — expected output: 44889
// build: rustc -O -o prog 10_pi.rs    run: ./prog
//
// Gibbons' unbounded spigot, summing the first 10000 digits it emits (leading 3 included)
// and never printing them. Rust's standard library has no big integers, so the state
// (q, r, t, k, n, l) is carried in base-1e9 limbs: multiply-by-small-int and add/sub are
// hand-written below, and the two divisions (by the big t and by t*l) take their small
// quotient by binary search on q*den <= num, which needs nothing but that same
// multiply-by-small-int and a comparison.

use std::cmp::Ordering;

const BASE: u64 = 1_000_000_000;
const DIGITS: usize = 10_000;
// The spigot only ever divides by the big t (or t*l), and always for a quotient that is a
// digit or a digit times ten: floor(10*(3q+r)/t) = next_digit + 10*previous_digit <= 99,
// and the next digit itself is 0..9. Both bounds are exclusive and have room to spare.
const BOUND_SCALE: u64 = 256;
const BOUND_DIGIT: u64 = 32;

struct Big {
    neg: bool,
    limbs: Vec<u64>, // little-endian, base 1e9, no leading zeros, empty means zero
}

impl Big {
    fn norm(neg: bool, mut limbs: Vec<u64>) -> Big {
        while let Some(&0) = limbs.last() {
            limbs.pop();
        }
        Big { neg: neg && !limbs.is_empty(), limbs }
    }

    fn zero() -> Big {
        Big { neg: false, limbs: Vec::new() }
    }

    fn from_u64(mut n: u64) -> Big {
        let mut limbs = Vec::new();
        while n > 0 {
            limbs.push(n % BASE);
            n /= BASE;
        }
        Big { neg: false, limbs }
    }

    fn is_zero(&self) -> bool {
        self.limbs.is_empty()
    }

    fn cmp(&self, other: &Big) -> Ordering {
        if self.neg != other.neg {
            return if self.neg { Ordering::Less } else { Ordering::Greater };
        }
        let c = mag_cmp(&self.limbs, &other.limbs);
        if self.neg { c.reverse() } else { c }
    }

    fn add(&self, other: &Big) -> Big {
        if self.neg == other.neg {
            Big::norm(self.neg, mag_add(&self.limbs, &other.limbs))
        } else {
            match mag_cmp(&self.limbs, &other.limbs) {
                Ordering::Greater => Big::norm(self.neg, mag_sub(&self.limbs, &other.limbs)),
                Ordering::Less => Big::norm(other.neg, mag_sub(&other.limbs, &self.limbs)),
                Ordering::Equal => Big::zero(),
            }
        }
    }

    fn sub(&self, other: &Big) -> Big {
        if self.neg != other.neg {
            Big::norm(self.neg, mag_add(&self.limbs, &other.limbs))
        } else {
            match mag_cmp(&self.limbs, &other.limbs) {
                Ordering::Greater => Big::norm(self.neg, mag_sub(&self.limbs, &other.limbs)),
                Ordering::Less => Big::norm(!self.neg, mag_sub(&other.limbs, &self.limbs)),
                Ordering::Equal => Big::zero(),
            }
        }
    }

    fn mul_small(&self, m: u64) -> Big {
        if m == 0 || self.is_zero() {
            return Big::zero();
        }
        let mut out = Vec::with_capacity(self.limbs.len() + 2);
        let mut carry = 0u64;
        for &limb in &self.limbs {
            let p = limb * m + carry;
            out.push(p % BASE);
            carry = p / BASE;
        }
        while carry > 0 {
            out.push(carry % BASE);
            carry /= BASE;
        }
        Big::norm(self.neg, out)
    }

    /// floor(self / den), for den > 0 and |result| < bound.
    fn div_floor(&self, den: &Big, bound: u64) -> i64 {
        if self.neg {
            -(smallest_ge(&self.limbs, &den.limbs, bound) as i64)
        } else {
            largest_le(&self.limbs, &den.limbs, bound) as i64
        }
    }
}

fn mag_cmp(a: &[u64], b: &[u64]) -> Ordering {
    if a.len() != b.len() {
        return a.len().cmp(&b.len());
    }
    for i in (0..a.len()).rev() {
        if a[i] != b[i] {
            return a[i].cmp(&b[i]);
        }
    }
    Ordering::Equal
}

fn mag_add(a: &[u64], b: &[u64]) -> Vec<u64> {
    let (long, short) = if a.len() >= b.len() { (a, b) } else { (b, a) };
    let mut out = Vec::with_capacity(long.len() + 1);
    let mut carry = 0u64;
    for i in 0..long.len() {
        let s = long[i] + short.get(i).copied().unwrap_or(0) + carry;
        out.push(s % BASE);
        carry = s / BASE;
    }
    if carry > 0 {
        out.push(carry);
    }
    out
}

/// a - b, requires a >= b.
fn mag_sub(a: &[u64], b: &[u64]) -> Vec<u64> {
    let mut out = Vec::with_capacity(a.len());
    let mut borrow = 0u64;
    for i in 0..a.len() {
        let bi = b.get(i).copied().unwrap_or(0);
        if a[i] >= bi + borrow {
            out.push(a[i] - bi - borrow);
            borrow = 0;
        } else {
            out.push(a[i] + BASE - bi - borrow);
            borrow = 1;
        }
    }
    while let Some(&0) = out.last() {
        out.pop();
    }
    out
}

/// compare q * d with the magnitude a, q being a small multiplier.
fn cmp_mul_mag(d: &[u64], q: u64, a: &[u64]) -> Ordering {
    let mut carry = 0u64;
    let mut i = 0usize;
    while i < d.len() || carry > 0 {
        let di = if i < d.len() { d[i] } else { 0 };
        let p = di * q + carry;
        let limb = p % BASE;
        carry = p / BASE;
        let ai = if i < a.len() { a[i] } else { 0 };
        if limb != ai {
            return limb.cmp(&ai);
        }
        i += 1;
    }
    while i < a.len() {
        if a[i] != 0 {
            return Ordering::Less;
        }
        i += 1;
    }
    Ordering::Equal
}

/// largest q < bound with q * d <= a.
fn largest_le(a: &[u64], d: &[u64], bound: u64) -> u64 {
    let mut lo = 0u64;
    let mut hi = bound;
    while lo + 1 < hi {
        let mid = lo + (hi - lo) / 2;
        if cmp_mul_mag(d, mid, a) == Ordering::Greater {
            hi = mid;
        } else {
            lo = mid;
        }
    }
    lo
}

/// smallest q < bound with q * d >= a.
fn smallest_ge(a: &[u64], d: &[u64], bound: u64) -> u64 {
    let mut lo = 0u64;
    let mut hi = bound;
    while lo < hi {
        let mid = lo + (hi - lo) / 2;
        if cmp_mul_mag(d, mid, a) == Ordering::Less {
            lo = mid + 1;
        } else {
            hi = mid;
        }
    }
    lo
}

fn main() {
    let mut q = Big::from_u64(1);
    let mut r = Big::zero();
    let mut t = Big::from_u64(1);
    let mut k: u64 = 1;
    let mut n: i64 = 3;
    let mut l: u64 = 3;

    let mut sum: i64 = 0;
    let mut emitted: usize = 0;

    while emitted < DIGITS {
        // 4*q + r - t < n*t ?
        let lhs = q.mul_small(4).add(&r).sub(&t);
        let rhs = t.mul_small(n as u64);

        if lhs.cmp(&rhs) == Ordering::Less {
            // the digit is safe: emit n and advance
            sum += n;
            emitted += 1;
            let next_n = q.mul_small(3).add(&r).mul_small(10).div_floor(&t, BOUND_SCALE) - 10 * n;
            q = q.mul_small(10);
            r = r.sub(&t.mul_small(n as u64)).mul_small(10);
            n = next_n;
        } else {
            let next_n = q
                .mul_small(7 * k + 2)
                .add(&r.mul_small(l))
                .div_floor(&t.mul_small(l), BOUND_DIGIT);
            let next_r = q.mul_small(2).add(&r).mul_small(l);
            let next_q = q.mul_small(k);
            let next_t = t.mul_small(l);
            q = next_q;
            r = next_r;
            t = next_t;
            k += 1;
            n = next_n;
            l += 2;
        }
    }

    println!("{}", sum);
}
