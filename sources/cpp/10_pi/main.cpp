// task 10 pi — expected output: 44889
// build: g++ -O2 -pthread -o prog main.cpp    run: ./prog
// also builds with: clang++ -O2 -pthread -o prog main.cpp | cl /O2 /EHsc /Fe:prog main.cpp
// note: Gibbons' unbounded spigot. C++ has no standard big integer, so the spigot state is
//       kept as a hand-written big integer of 64-bit limbs in base 1000000000, held in a
//       std::vector, with hand-written multiply-by-small and divide-by-small. Only the sum
//       of the first 10000 emitted digits is printed, never the digits.

#include <cstdio>
#include <vector>

namespace {

const unsigned long long BASE = 1000000000ULL;

// Sign-magnitude big integer: little-endian base-1e9 limbs, no high zero limbs.
struct Big {
    bool neg = false;
    std::vector<unsigned long long> d;

    bool isZero() const { return d.empty(); }
};

void trim(Big& x) {
    while (!x.d.empty() && x.d.back() == 0) {
        x.d.pop_back();
    }
    if (x.d.empty()) {
        x.neg = false;
    }
}

Big fromU64(unsigned long long v) {
    Big x;
    while (v != 0) {
        x.d.push_back(v % BASE);
        v /= BASE;
    }
    return x;
}

int cmpMag(const Big& a, const Big& b) {
    if (a.d.size() != b.d.size()) {
        return a.d.size() < b.d.size() ? -1 : 1;
    }
    for (size_t i = a.d.size(); i-- > 0;) {
        if (a.d[i] != b.d[i]) {
            return a.d[i] < b.d[i] ? -1 : 1;
        }
    }
    return 0;
}

Big addMag(const Big& a, const Big& b) {
    Big r;
    const size_t n = a.d.size() > b.d.size() ? a.d.size() : b.d.size();
    r.d.resize(n, 0);
    unsigned long long carry = 0;
    for (size_t i = 0; i < n; ++i) {
        unsigned long long s = carry;
        if (i < a.d.size()) s += a.d[i];
        if (i < b.d.size()) s += b.d[i];
        if (s >= BASE) {
            s -= BASE;
            carry = 1;
        } else {
            carry = 0;
        }
        r.d[i] = s;
    }
    if (carry != 0) {
        r.d.push_back(carry);
    }
    trim(r);
    return r;
}

Big subMag(const Big& a, const Big& b) {  // requires a >= b
    Big r;
    r.d.resize(a.d.size(), 0);
    long long borrow = 0;
    for (size_t i = 0; i < a.d.size(); ++i) {
        long long s = static_cast<long long>(a.d[i]) - borrow;
        if (i < b.d.size()) s -= static_cast<long long>(b.d[i]);
        if (s < 0) {
            s += static_cast<long long>(BASE);
            borrow = 1;
        } else {
            borrow = 0;
        }
        r.d[i] = static_cast<unsigned long long>(s);
    }
    trim(r);
    return r;
}

Big mulMag(const Big& a, unsigned long long m) {  // magnitude times a small factor
    Big r;
    r.d.resize(a.d.size(), 0);
    unsigned long long carry = 0;
    for (size_t i = 0; i < a.d.size(); ++i) {
        const unsigned long long cur = a.d[i] * m + carry;
        r.d[i] = cur % BASE;
        carry = cur / BASE;
    }
    while (carry != 0) {
        r.d.push_back(carry % BASE);
        carry /= BASE;
    }
    trim(r);
    return r;
}

Big mulSigned(const Big& a, unsigned long long m) {
    Big r = mulMag(a, m);
    if (!r.isZero()) r.neg = a.neg;
    return r;
}

Big negate(Big a) {
    if (!a.isZero()) a.neg = !a.neg;
    return a;
}

Big addSigned(const Big& a, const Big& b) {
    if (a.neg == b.neg) {
        Big r = addMag(a, b);
        if (!r.isZero()) r.neg = a.neg;
        return r;
    }
    const int c = cmpMag(a, b);
    if (c == 0) return Big();
    if (c > 0) {
        Big r = subMag(a, b);
        r.neg = a.neg;
        return r;
    }
    Big r = subMag(b, a);
    r.neg = b.neg;
    return r;
}

Big subSigned(const Big& a, const Big& b) {
    return addSigned(a, negate(b));
}

int cmpSigned(const Big& a, const Big& b) {
    if (a.neg != b.neg) return a.neg ? -1 : 1;
    const int c = cmpMag(a, b);
    return a.neg ? -c : c;
}

// Value of the top k limb positions of x as a double; only used to seed a quotient guess.
double topValue(const Big& x, size_t k) {
    double v = 0.0;
    const long long n = static_cast<long long>(x.d.size());
    for (size_t p = 0; p < k; ++p) {
        v *= 1e9;
        const long long idx = n - static_cast<long long>(k) + static_cast<long long>(p);
        if (idx >= 0 && idx < n) v += static_cast<double>(x.d[static_cast<size_t>(idx)]);
    }
    return v;
}

unsigned long long toU64(const Big& x) {  // magnitude, assumed to fit in 64 bits
    unsigned long long v = 0;
    for (size_t i = x.d.size(); i-- > 0;) {
        v = v * BASE + x.d[i];
    }
    return v;
}

// floor(num / den) with den > 0; the caller guarantees |num / den| < 1000000000.
Big divFloorSmallQ(const Big& num, const Big& den) {
    const bool negative = num.neg;
    unsigned long long q = 0;
    Big prod;  // den * q
    bool exact = true;

    if (cmpMag(num, den) >= 0) {
        double est = topValue(num, 3) / topValue(den, 3);
        for (size_t i = 0; i < num.d.size() - den.d.size(); ++i) {
            est *= 1e9;
        }
        if (!(est >= 0.0)) est = 0.0;
        if (est > 9.0e8) est = 9.0e8;
        q = static_cast<unsigned long long>(est);

        prod = mulMag(den, q);
        while (cmpMag(prod, num) > 0) {
            --q;
            prod = subMag(prod, den);
        }
        for (;;) {
            Big next = addMag(prod, den);
            if (cmpMag(next, num) > 0) break;
            ++q;
            prod = next;
        }
        exact = cmpMag(prod, num) == 0;
    } else {
        exact = num.isZero();
    }

    if (!negative) {
        return fromU64(q);
    }
    Big r = fromU64(q + (exact ? 0ULL : 1ULL));  // floor for a negative numerator
    if (!r.isZero()) r.neg = true;
    return r;
}

}  // namespace

int main() {
    Big q = fromU64(1);
    Big r;  // zero
    Big t = fromU64(1);
    unsigned long long k = 1;
    unsigned long long n = 3;
    unsigned long long l = 3;

    const long long wanted = 10000;
    long long emitted = 0;
    long long total = 0;

    while (emitted < wanted) {
        // emit n while 4*q + r - t < n*t
        const Big cond = subSigned(subSigned(addSigned(mulSigned(q, 4), r), t), mulSigned(t, n));
        if (cmpSigned(cond, Big()) < 0) {
            total += static_cast<long long>(n);
            ++emitted;

            const Big num = mulSigned(addSigned(mulSigned(q, 3), r), 10);
            const Big next = subSigned(divFloorSmallQ(num, t), fromU64(10 * n));
            const Big newQ = mulSigned(q, 10);
            const Big newR = mulSigned(subSigned(r, mulSigned(t, n)), 10);

            n = toU64(next);
            q = newQ;
            r = newR;
        } else {
            const Big num = addSigned(mulSigned(q, 7 * k + 2), mulSigned(r, l));
            const Big den = mulSigned(t, l);
            const Big next = divFloorSmallQ(num, den);
            const Big newQ = mulSigned(q, k);
            const Big newR = mulSigned(addSigned(mulSigned(q, 2), r), l);

            n = toU64(next);
            q = newQ;
            r = newR;
            t = den;
            k += 1;
            l += 2;
        }
    }

    std::printf("%lld\n", total);
    return 0;
}
