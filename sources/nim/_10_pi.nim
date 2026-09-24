# task 10 pi — expected output: 44889
# build: nim c -d:release -o:prog _10_pi.nim    run: ./prog
#
# Deviation: Nim's standard library has no arbitrary-precision integer type
# (there is no `std/bigints` module in Nim 2.0), so the Gibbons unbounded
# spigot runs on hand-written base-10^9 limbs: multiply-by-small-int, plus a
# big-by-big divide whose quotient is a single digit, found by doubling.
# The digits themselves are never printed.

const Base: int64 = 1_000_000_000

type
  Big = object
    neg: bool
    m: seq[int64] # little-endian limbs, each in 0 ..< Base, no leading zeros

proc trim(a: var seq[int64]) =
  while a.len > 0 and a[^1] == 0:
    a.setLen(a.len - 1)

proc cmpMag(a, b: seq[int64]): int =
  if a.len != b.len:
    return (if a.len < b.len: -1 else: 1)
  var i = a.high
  while i >= 0:
    if a[i] != b[i]:
      return (if a[i] < b[i]: -1 else: 1)
    dec i
  return 0

proc addMag(a, b: seq[int64]): seq[int64] =
  let n = max(a.len, b.len)
  result = newSeq[int64](n + 1)
  var carry: int64 = 0
  for i in 0 ..< n:
    var s = carry
    if i < a.len: s += a[i]
    if i < b.len: s += b[i]
    result[i] = s mod Base
    carry = s div Base
  result[n] = carry
  trim(result)

proc subMag(a, b: seq[int64]): seq[int64] =
  ## a - b for magnitudes, requires a >= b.
  result = newSeq[int64](a.len)
  var borrow: int64 = 0
  for i in 0 ..< a.len:
    var s = a[i] - borrow
    if i < b.len: s -= b[i]
    if s < 0:
      s += Base
      borrow = 1
    else:
      borrow = 0
    result[i] = s
  trim(result)

proc toBig(x: int64): Big =
  var v = x
  if v < 0:
    result.neg = true
    v = -v
  while v > 0:
    result.m.add(v mod Base)
    v = v div Base

proc isZero(a: Big): bool =
  a.m.len == 0

proc negate(a: Big): Big =
  if a.m.len == 0:
    return Big(neg: false, m: @[])
  return Big(neg: not a.neg, m: a.m)

proc add(a, b: Big): Big =
  if a.neg == b.neg:
    result = Big(neg: a.neg, m: addMag(a.m, b.m))
    if result.m.len == 0:
      result.neg = false
    return
  let c = cmpMag(a.m, b.m)
  if c == 0:
    return Big(neg: false, m: @[])
  if c > 0:
    return Big(neg: a.neg, m: subMag(a.m, b.m))
  return Big(neg: b.neg, m: subMag(b.m, a.m))

proc sub(a, b: Big): Big =
  add(a, negate(b))

proc cmpBig(a, b: Big): int =
  if a.neg != b.neg:
    return (if a.neg: -1 else: 1)
  let c = cmpMag(a.m, b.m)
  if a.neg:
    return -c
  return c

proc mulSmall(a: Big, k: int64): Big =
  ## a * k, for k >= 0.
  if k == 0 or a.m.len == 0:
    return Big(neg: false, m: @[])
  result = Big(neg: a.neg, m: newSeq[int64](a.m.len + 1))
  var carry: int64 = 0
  for i in 0 ..< a.m.len:
    let p = a.m[i] * k + carry
    result.m[i] = p mod Base
    carry = p div Base
  result.m[^1] = carry
  trim(result.m)

proc divFloor(a, b: Big): int64 =
  ## floor(a / b) for b > 0, with the quotient small enough to fit in an int64.
  if isZero(a):
    return 0
  var rem = Big(neg: false, m: a.m)
  var powers: seq[Big] = @[]
  var cur = Big(neg: false, m: b.m)
  while cmpBig(cur, rem) <= 0:
    powers.add cur
    cur = mulSmall(cur, 2)
    if powers.len > 62: break
  var q: int64 = 0
  for i in countdown(powers.high, 0):
    if cmpBig(powers[i], rem) <= 0:
      rem = sub(rem, powers[i])
      q += 1'i64 shl i
  if not a.neg:
    return q
  if isZero(rem):
    return -q
  return -(q + 1)

proc main() =
  var q = toBig(1)
  var r = toBig(0)
  var t = toBig(1)
  var k: int64 = 1
  var n: int64 = 3
  var l: int64 = 3
  var total: int64 = 0
  var emitted = 0
  while emitted < 10_000:
    # 4*q + r - t < n*t
    let test = sub(add(mulSmall(q, 4), r), mulSmall(t, n + 1))
    if test.neg:
      total += n
      inc emitted
      let nextN = divFloor(mulSmall(add(mulSmall(q, 3), r), 10), t) - 10 * n
      let nextR = mulSmall(sub(r, mulSmall(t, n)), 10)
      q = mulSmall(q, 10)
      r = nextR
      n = nextN
    else:
      let nextN = divFloor(add(mulSmall(q, 7 * k + 2), mulSmall(r, l)), mulSmall(t, l))
      let nextR = mulSmall(add(mulSmall(q, 2), r), l)
      let nextT = mulSmall(t, l)
      q = mulSmall(q, k)
      r = nextR
      t = nextT
      n = nextN
      inc k
      l = l + 2
  echo total

main()
