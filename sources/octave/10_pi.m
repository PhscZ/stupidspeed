# task 10 pi — expected output: 4470
# build: none (interpreted)    run: octave-cli -qf 10_pi.m
#
# Unbounded spigot (Gibbons), emitting the leading 3 first, summing the first
# 1000 digits it emits. Octave has no arbitrary-precision integer, so the state
# (q, r, t) is carried as sign/magnitude vectors of base-10^9 limbs, with the
# multiply-by-a-small-integer, the add, the subtract and the compare written by
# hand, exactly as sources/c/10_pi.c does it.
# note: the limb helpers are defined above the driver, in this same file, because
# Octave defines a script's local functions only when their definition is
# executed. The leading 1; keeps the first token of the file from being
# `function`, which is what makes this a script with local functions.
# note: the limbs are int64, not doubles. 1e9 * 1e9 = 1e18 fits in int64, and the
# spigot only ever multiplies a limb by a small integer (10, k, l, 7k + 2, 4, 3),
# so every intermediate stays far below 9.2e18 and nothing overflows. Octave's
# integer arithmetic saturates on overflow rather than wrapping, which would be a
# silent wrong answer, so every operand is kept int64 and every division is exact
# by construction or explicitly floored with idivide.
# note: the quotient is not a literal repeated-subtraction loop. The spigot asks
# for a big/big quotient once per step; a normalised two-limb estimate clamped to
# 4096, then corrected by one or two subtracts, is what the merged R row does
# (sources/r/10_pi.R) and it is exact for any quotient.
# note: this cell is quadratic in the digit count and is one of the slower cells
# in the row; see RUN.md.

1;
__t0 = tic;

# --- base-10^9 limbs, little-endian, no leading zero limbs -------------------
# A bignum is a struct: s is the sign, m the int64 row vector of limbs. The
# helpers carry a trailing underscore so they cannot collide with anything on the
# load path.

function x = mk_(m, s)
  n = numel(m);
  while n > 1 && m(n) == 0
    n = n - 1;
  end
  if n == 1 && m(1) == 0
    x = struct('s', 1, 'm', int64(0));
    return;
  end
  if n < numel(m)
    m = m(1:n);
  end
  x = struct('s', s, 'm', m);
end

function c = cmp_mag_(a, b)
  if numel(a) ~= numel(b)
    if numel(a) > numel(b)
      c = 1;
    else
      c = -1;
    end
    return;
  end
  d = find(a ~= b);
  if isempty(d)
    c = 0;
    return;
  end
  i = d(numel(d));
  if a(i) > b(i)
    c = 1;
  else
    c = -1;
  end
end

function c = cmp_(x, y)
  if x.s ~= y.s
    if x.s > y.s
      c = 1;
    else
      c = -1;
    end
    return;
  end
  c = x.s * cmp_mag_(x.m, y.m);
end

function s = trim_(s)
  n = numel(s);
  while n > 1 && s(n) == 0
    n = n - 1;
  end
  if n < numel(s)
    s = s(1:n);
  end
end

function s = add_mag_(a, b)
  BASE = int64(1000000000);
  la = numel(a);
  lb = numel(b);
  if la > lb
    n = la;
  else
    n = lb;
  end
  s = zeros(1, n, 'int64');
  s(1:la) = a;
  s(1:lb) = s(1:lb) + b;
  s = [s int64(0)];
  while true
    o = s >= BASE;
    if ~any(o)
      break;
    end
    oi = int64(o);
    s = s - oi * BASE;
    s = s + [int64(0) oi(1:numel(s) - 1)];
  end
  s = trim_(s);
end

function s = sub_mag_(a, b)          # requires a >= b
  BASE = int64(1000000000);
  s = a;
  lb = numel(b);
  s(1:lb) = s(1:lb) - b;
  while true
    o = s < 0;
    if ~any(o)
      break;
    end
    oi = int64(o);
    s = s + oi * BASE;
    s = s - [int64(0) oi(1:numel(s) - 1)];
  end
  s = trim_(s);
end

function z = add_(x, y)
  if x.s == y.s
    z = mk_(add_mag_(x.m, y.m), x.s);
    return;
  end
  k = cmp_mag_(x.m, y.m);
  if k == 0
    z = mk_(int64(0), 1);
    return;
  end
  if k > 0
    z = mk_(sub_mag_(x.m, y.m), x.s);
  else
    z = mk_(sub_mag_(y.m, x.m), y.s);
  end
end

function z = sub_(x, y)
  if numel(y.m) == 1 && y.m(1) == 0
    z = x;
    return;
  end
  y.s = -y.s;
  z = add_(x, y);
end

function z = mul_(x, m)
  BASE = int64(1000000000);
  if m == 0
    z = mk_(int64(0), 1);
    return;
  end
  p = x.m * int64(m);
  lo = mod(p, BASE);
  hi = (p - lo) / BASE;              # exact by construction
  s = [lo int64(0)] + [int64(0) hi];
  while true
    o = s >= BASE;
    if ~any(o)
      break;
    end
    oi = int64(o);
    s = s - oi * BASE;
    s = s + [int64(0) oi(1:numel(s) - 1)];
  end
  z = mk_(s, x.s);
end

# floor(A / B) for magnitudes. The spigot's quotients are small and the estimate
# from the two leading limbs is accurate to within one, so the correction loops
# take a step or two; they are exact for any quotient.
function q = div_(A, B)
  if cmp_mag_(A, B) < 0
    q = 0;
    return;
  end
  la = numel(A);
  lb = numel(B);
  if la >= 2
    a0 = double(A(la - 1));
  else
    a0 = 0;
  end
  if lb >= 2
    b0 = double(B(lb - 1));
  else
    b0 = 0;
  end
  est = ((double(A(la)) + a0 / 1e9) / (double(B(lb)) + b0 / 1e9)) * 1e9^(la - lb);
  if isfinite(est) && est > 0
    q = floor(est);
  else
    q = 0;
  end
  if q > 4096
    q = 4096;
  end
  P = mul_(mk_(B, 1), q).m;
  while cmp_mag_(P, A) > 0
    q = q - 1;
    P = sub_mag_(P, B);
  end
  while true
    Q = add_mag_(P, B);
    if cmp_mag_(Q, A) > 0
      break;
    end
    P = Q;
    q = q + 1;
  end
end

# --- the spigot --------------------------------------------------------------

NDIGITS = 1000;
BASE = int64(1000000000);

q = mk_(int64(1), 1);
r = mk_(int64(0), 1);
t = mk_(int64(1), 1);
k = 1;
n = 3;
l = 3;
total = 0;
# while, not for: this loop counts emitted digits, not iterations. The spigot
# spends some iterations only widening the state (the else branch below), so a
# loop of NDIGITS iterations would emit fewer than NDIGITS digits.
count = 0;
while count < NDIGITS
  if cmp_(sub_(add_(mul_(q, 4), r), t), mul_(t, n)) < 0
    # the digit n is settled
    total = total + n;
    count = count + 1;
    u = mul_(add_(mul_(q, 3), r), 10);
    nxt = div_(u.m, t.m) - 10 * n;
    newr = mul_(sub_(r, mul_(t, n)), 10);
    q = mul_(q, 10);
    r = newr;
    n = nxt;
  else
    # not settled yet: widen the state by one more term
    u = add_(mul_(q, 7 * k + 2), mul_(r, l));
    v = mul_(t, l);
    nxt = div_(u.m, v.m);
    newr = mul_(add_(mul_(q, 2), r), l);
    newt = mul_(t, l);
    q = mul_(q, k);
    r = newr;
    t = newt;
    k = k + 1;
    n = nxt;
    l = l + 2;
  end
end
fprintf(stderr, "TIME_MS=%.3f\n", toc(__t0) * 1000);
printf("%.0f\n", total);
