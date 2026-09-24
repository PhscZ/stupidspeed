// task 10 pi — expected output: 44889
// build: dart compile exe -o prog main.dart (aot; jit has no build step)    run: ./prog (aot) | dart main.dart (jit)
// Gibbons' unbounded spigot on hand-written base-10^9 limbs: dart:core has no big integers.
// Every intermediate stays below 2^53, so the arithmetic is exact if compiled to JavaScript too.

const int _base = 1000000000;

/// Signed arbitrary-precision integer: little-endian base-10^9 magnitude limbs.
/// The magnitude carries no trailing zero limbs; an empty magnitude is zero.
class Big {
  final List<int> m;
  final bool neg;

  const Big._(this.m, this.neg);

  static const Big zero = Big._(<int>[], false);

  static Big of(List<int> mag, bool negative) {
    int n = mag.length;
    while (n > 0 && mag[n - 1] == 0) {
      n--;
    }
    if (n == 0) {
      return zero;
    }
    return Big._(n == mag.length ? mag : mag.sublist(0, n), negative);
  }

  static Big fromInt(int v) {
    if (v == 0) {
      return zero;
    }
    return Big.of(<int>[v < 0 ? -v : v], v < 0);
  }

  static int cmpMag(List<int> a, List<int> b) {
    if (a.length != b.length) {
      return a.length < b.length ? -1 : 1;
    }
    for (int i = a.length - 1; i >= 0; i--) {
      if (a[i] != b[i]) {
        return a[i] < b[i] ? -1 : 1;
      }
    }
    return 0;
  }

  static int cmp(Big a, Big b) {
    if (a.neg != b.neg) {
      return a.neg ? -1 : 1;
    }
    final int c = cmpMag(a.m, b.m);
    return a.neg ? -c : c;
  }

  static List<int> addMag(List<int> a, List<int> b) {
    final int n = a.length > b.length ? a.length : b.length;
    final List<int> r = List<int>.filled(n + 1, 0);
    int carry = 0;
    for (int i = 0; i < n; i++) {
      int v = carry;
      if (i < a.length) {
        v += a[i];
      }
      if (i < b.length) {
        v += b[i];
      }
      if (v >= _base) {
        v -= _base;
        carry = 1;
      } else {
        carry = 0;
      }
      r[i] = v;
    }
    if (carry != 0) {
      r[n] = carry;
      return r;
    }
    return r.sublist(0, n);
  }

  /// a - b for a >= b, both non-negative.
  static List<int> subMag(List<int> a, List<int> b) {
    final int n = a.length;
    final List<int> r = List<int>.filled(n, 0);
    int borrow = 0;
    for (int i = 0; i < n; i++) {
      int v = a[i] - borrow - (i < b.length ? b[i] : 0);
      if (v < 0) {
        v += _base;
        borrow = 1;
      } else {
        borrow = 0;
      }
      r[i] = v;
    }
    return r;
  }

  static Big add(Big a, Big b) {
    if (a.neg == b.neg) {
      return Big.of(addMag(a.m, b.m), a.neg);
    }
    final int c = cmpMag(a.m, b.m);
    if (c == 0) {
      return zero;
    }
    if (c > 0) {
      return Big.of(subMag(a.m, b.m), a.neg);
    }
    return Big.of(subMag(b.m, a.m), b.neg);
  }

  static Big negate(Big a) => a.m.isEmpty ? a : Big._(a.m, !a.neg);

  static Big sub(Big a, Big b) => add(a, negate(b));

  /// Multiply by a small non-negative integer.
  static Big mulSmall(Big a, int m) {
    if (m == 0 || a.m.isEmpty) {
      return zero;
    }
    final List<int> r = List<int>.filled(a.m.length + 1, 0);
    int carry = 0;
    for (int i = 0; i < a.m.length; i++) {
      final int v = a.m[i] * m + carry;
      r[i] = v % _base;
      carry = v ~/ _base;
    }
    int n = a.m.length;
    if (carry != 0) {
      r[n] = carry;
      n++;
    }
    return Big.of(r.sublist(0, n), a.neg);
  }

  /// floor(x / y) for y > 0 and a small quotient, by repeated subtraction.
  static int divSmall(Big x, Big y) {
    int q = 0;
    if (x.neg) {
      while (cmp(x, zero) < 0) {
        x = add(x, y);
        q -= 1;
      }
    } else {
      final Big y10 = mulSmall(y, 10);
      while (cmp(x, y10) >= 0) {
        x = sub(x, y10);
        q += 10;
      }
      while (cmp(x, y) >= 0) {
        x = sub(x, y);
        q += 1;
      }
    }
    return q;
  }
}

void main() {
  Big q = Big.fromInt(1);
  Big r = Big.fromInt(0);
  Big t = Big.fromInt(1);
  int k = 1;
  int n = 3;
  int l = 3;

  const int digits = 10000;
  int emitted = 0;
  int digitSum = 0;
  while (emitted < digits) {
    final Big nt = Big.mulSmall(t, n);
    final Big lhs = Big.sub(Big.add(Big.mulSmall(q, 4), r), t);
    if (Big.cmp(lhs, nt) < 0) {
      digitSum += n;
      emitted++;
      final Big q2 = Big.mulSmall(q, 10);
      final Big r2 = Big.mulSmall(Big.sub(r, nt), 10);
      n = Big.divSmall(Big.mulSmall(Big.add(Big.mulSmall(q, 3), r), 10), t) - 10 * n;
      q = q2;
      r = r2;
    } else {
      final Big q2 = Big.mulSmall(q, k);
      final Big r2 = Big.mulSmall(Big.add(Big.mulSmall(q, 2), r), l);
      final Big t2 = Big.mulSmall(t, l);
      n = Big.divSmall(Big.add(Big.mulSmall(q, 7 * k + 2), Big.mulSmall(r, l)), t2);
      q = q2;
      r = r2;
      t = t2;
      k += 1;
      l += 2;
    }
  }
  print(digitSum);
}
