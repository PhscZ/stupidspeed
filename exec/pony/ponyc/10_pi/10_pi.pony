// task 10 pi — expected output: 4470
// timing: Time.nanos() is Pony's monotonic clock (QueryPerformanceCounter on Windows);
//        TIME_MS goes to stderr with env.err.print and stdout is unchanged.
// build: mkdir -p temp/pony/10_pi && cp sources/pony/10_pi.pony temp/pony/10_pi/ && tools/ponyc/bin/ponyc.exe -o temp/pony/10_pi temp/pony/10_pi
// run: temp/pony/10_pi/10_pi.exe
// note: Pony's standard library has no arbitrary-precision integers, so this hand-rolls
//       sign-magnitude, little-endian, base-1e9 limbs, as the task description allows.
//       The spigot only ever asks for one decimal digit at a time: both divisions in the loop
//       have a quotient of at most 99 (measured on the reference run), so the quotient comes
//       out of repeated subtraction and no general long division is needed. The numerators of
//       both divisions are always non-negative, so repeated subtraction is exactly floor
//       division. The intermediate r does go negative, which is why the sign is carried.
// note: the algorithm is Gibbons' unbounded spigot, the same loop as every other row.


use "time"
primitive BigMag
  """
  Unsigned base-1e9 limb arithmetic. Limbs are little-endian, U32, no leading zeros;
  an empty array is zero.
  """

  fun add(a: Array[U32] box, b: Array[U32] box): Array[U32]^ =>
    let r = Array[U32]
    let an = a.size()
    let bn = b.size()
    let n = an.max(bn)
    var carry: U64 = 0
    try
      var i: USize = 0
      while i < n do
        var s = carry
        if i < an then s = s + a(i)?.u64() end
        if i < bn then s = s + b(i)?.u64() end
        r.push((s % 1000000000).u32())
        carry = s / 1000000000
        i = i + 1
      end
    end
    if carry > 0 then r.push(carry.u32()) end
    r

  fun sub(a: Array[U32] box, b: Array[U32] box): Array[U32]^ =>
    """a - b for a > b."""
    let r = Array[U32]
    let an = a.size()
    let bn = b.size()
    var borrow: I64 = 0
    try
      var i: USize = 0
      while i < an do
        var d: I64 = a(i)?.i64() - borrow
        if i < bn then d = d - b(i)?.i64() end
        if d < 0 then
          d = d + 1000000000
          borrow = 1
        else
          borrow = 0
        end
        r.push(d.u32())
        i = i + 1
      end
    end
    strip(r)
    r

  fun cmp(a: Array[U32] box, b: Array[U32] box): I64 =>
    let an = a.size()
    let bn = b.size()
    if an != bn then
      if an > bn then 1 else -1 end
    else
      var res: I64 = 0
      var i = an
      try
        while (i > 0) and (res == 0) do
          i = i - 1
          let av = a(i)?
          let bv = b(i)?
          if av > bv then
            res = 1
          elseif av < bv then
            res = -1
          end
        end
      end
      res
    end

  fun strip(r: Array[U32] ref) =>
    try
      while (r.size() > 0) and (r(r.size() - 1)? == 0) do
        r.truncate(r.size() - 1)
      end
    end

  fun mul(a: Array[U32] box, m: U64): Array[U32]^ =>
    let r = Array[U32]
    var carry: U64 = 0
    let an = a.size()
    try
      var i: USize = 0
      while i < an do
        let v = (a(i)?.u64() * m) + carry
        r.push((v % 1000000000).u32())
        carry = v / 1000000000
        i = i + 1
      end
    end
    while carry > 0 do
      r.push((carry % 1000000000).u32())
      carry = carry / 1000000000
    end
    strip(r)
    r

  fun div_floor(num: Array[U32] box, den: Array[U32] box): U64 =>
    """
    floor(num / den) for num >= 0 and den > 0. The spigot's quotients are single digits,
    so counting repeated subtractions is the whole division.
    """
    let rem = num.clone()
    var quo: U64 = 0
    while cmp(rem, den) >= 0 do
      sub_in_place(rem, den)
      quo = quo + 1
    end
    quo

  fun sub_in_place(a: Array[U32] ref, b: Array[U32] box) =>
    """a -= b for a >= b."""
    let bn = b.size()
    var borrow: I64 = 0
    try
      var i: USize = 0
      while i < bn do
        var d: I64 = a(i)?.i64() - borrow - b(i)?.i64()
        if d < 0 then
          d = d + 1000000000
          borrow = 1
        else
          borrow = 0
        end
        a(i)? = d.u32()
        i = i + 1
      end
      var j = bn
      while borrow > 0 do
        var d: I64 = a(j)?.i64() - borrow
        if d < 0 then
          d = d + 1000000000
          borrow = 1
        else
          borrow = 0
        end
        a(j)? = d.u32()
        j = j + 1
      end
    end
    strip(a)

class Big
  var _m: Array[U32]
  var _n: Bool

  new create() =>
    _m = Array[U32]
    _n = false

  new from_u64(v: U64) =>
    _m = Array[U32]
    _n = false
    var x = v
    while x > 0 do
      _m.push((x % 1000000000).u32())
      x = x / 1000000000
    end

  fun box cmp(that: Big box): I64 =>
    if _n != that._n then
      if _n then -1 else 1 end
    else
      let c = BigMag.cmp(_m, that._m)
      if _n then -c else c end
    end

  fun box add(that: Big box): Big =>
    let r = Big.create()
    if _n == that._n then
      r._m = BigMag.add(_m, that._m)
      r._n = if r._m.size() > 0 then _n else false end
    else
      let c = BigMag.cmp(_m, that._m)
      if c > 0 then
        r._m = BigMag.sub(_m, that._m)
        r._n = _n
      elseif c < 0 then
        r._m = BigMag.sub(that._m, _m)
        r._n = that._n
      else
        r._m = Array[U32]
        r._n = false
      end
    end
    r

  fun box sub(that: Big box): Big => add(that.negated())

  fun box negated(): Big =>
    let r = Big.create()
    r._m = _m.clone()
    r._n = if _m.size() > 0 then not _n else false end
    r

  fun box mul_small(m: U64): Big =>
    let r = Big.create()
    if _m.size() > 0 then
      r._n = _n
      r._m = BigMag.mul(_m, m)
      if r._m.size() == 0 then r._n = false end
    end
    r

  fun box div_small(den: Big box): U64 => BigMag.div_floor(_m, den._m)

class SsClock
  var t0: U64 = 0
  let env: Env
  new create(env': Env) =>
    env = env'
  fun ref start() =>
    t0 = Time.nanos()
  fun ref report() =>
    env.err.print("TIME_MS=" + ((Time.nanos() - t0) / 1000000).string())

actor Main
  new create(env: Env) =>
    let ss = SsClock(env)
    ss.start()
    var q = Big.from_u64(1)
    var r = Big.from_u64(0)
    var t = Big.from_u64(1)
    var k: U64 = 1
    var n: U64 = 3
    var l: U64 = 3

    var sum: U64 = 0
    var emitted: USize = 0
    while emitted < 1000 do
      // if 4*q + r - t < n*t then emit n
      let lhs = q.mul_small(4).add(r).sub(t)
      let rhs = t.mul_small(n)
      if lhs.cmp(rhs) < 0 then
        sum = sum + n
        emitted = emitted + 1
        // q, r, t, k, n, l = 10*q, 10*(r-n*t), t, k, (10*(3*q+r))/t - 10*n, l
        let nq = q.mul_small(10)
        let nr = r.sub(t.mul_small(n)).mul_small(10)
        let nn = q.mul_small(3).add(r).mul_small(10).div_small(t) - (10 * n)
        q = nq
        r = nr
        n = nn
      else
        // q, r, t, k, n, l = q*k, (2*q+r)*l, t*l, k+1, (q*(7*k+2)+r*l)/(t*l), l+2
        let nq = q.mul_small(k)
        let nr = q.mul_small(2).add(r).mul_small(l)
        let nt = t.mul_small(l)
        let nn = q.mul_small((7 * k) + 2).add(r.mul_small(l)).div_small(nt)
        q = nq
        r = nr
        t = nt
        k = k + 1
        n = nn
        l = l + 2
      end
    end
    ss.report()
    env.out.print(sum.string())
