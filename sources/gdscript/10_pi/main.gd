# task 10 pi — expected output: 44889
# build: godot --headless --script main.gd    run: godot --headless --script main.gd
# note: GDScript has no big integers, so the unbounded spigot (Gibbons) runs on hand-written
#       base-10^9 limbs: multiply by a small integer, add, subtract, and one big division
#       whose quotient is known to be small. Only the digit sum is printed.
# note: the spigot state grows to about 145000 decimal digits by the 10000th digit, so this
#       task does billions of limb operations in GDScript and may hit the 300 s timeout.
#       That is a legitimate DNF result, the same way RUN.md describes Nushell.

extends SceneTree

const LIMB_BASE := 1000000000
const DIGITS := 10000
const QUOT_MAX := 1000000

# Signed arbitrary-precision integer: a sign flag plus little-endian base-10^9 limbs.
class Big:
	var neg: bool
	var limbs: PackedInt64Array

	func _init(p_neg: bool, p_limbs: PackedInt64Array) -> void:
		neg = p_neg
		limbs = p_limbs

# ---- magnitude arithmetic (little-endian, base 10^9, result always trimmed) ----

func _mul_limbs(d: PackedInt64Array, m: int) -> PackedInt64Array:
	var n := d.size()
	var out := PackedInt64Array()
	out.resize(n + 1)
	var carry := 0
	for i in n:
		var cur := d[i] * m + carry
		out[i] = cur % LIMB_BASE
		carry = cur / LIMB_BASE
	out[n] = carry
	var top := n
	while top > 0 and out[top] == 0:
		top -= 1
	out.resize(top + 1)
	return out

func _add_limbs(a: PackedInt64Array, b: PackedInt64Array) -> PackedInt64Array:
	var n := maxi(a.size(), b.size())
	var out := PackedInt64Array()
	out.resize(n + 1)
	var carry := 0
	for i in n:
		var cur := carry
		if i < a.size():
			cur += a[i]
		if i < b.size():
			cur += b[i]
		out[i] = cur % LIMB_BASE
		carry = cur / LIMB_BASE
	out[n] = carry
	var top := n
	while top > 0 and out[top] == 0:
		top -= 1
	out.resize(top + 1)
	return out

func _sub_limbs(a: PackedInt64Array, b: PackedInt64Array) -> PackedInt64Array:
	# a must be greater than or equal to b
	var out := PackedInt64Array()
	out.resize(a.size())
	var borrow := 0
	for i in a.size():
		var cur := a[i] - borrow
		if i < b.size():
			cur -= b[i]
		if cur < 0:
			cur += LIMB_BASE
			borrow = 1
		else:
			borrow = 0
		out[i] = cur
	var top := out.size() - 1
	while top > 0 and out[top] == 0:
		top -= 1
	out.resize(top + 1)
	return out

func _cmp_limbs(a: PackedInt64Array, b: PackedInt64Array) -> int:
	if a.size() != b.size():
		return 1 if a.size() > b.size() else -1
	for i in range(a.size() - 1, -1, -1):
		if a[i] != b[i]:
			return 1 if a[i] > b[i] else -1
	return 0

# ---- signed arithmetic ----

func _big(neg: bool, limbs: PackedInt64Array) -> Big:
	if limbs.size() == 1 and limbs[0] == 0:
		return Big.new(false, limbs)
	return Big.new(neg, limbs)

func _add(a: Big, b: Big) -> Big:
	if a.neg == b.neg:
		return _big(a.neg, _add_limbs(a.limbs, b.limbs))
	var c := _cmp_limbs(a.limbs, b.limbs)
	if c == 0:
		return Big.new(false, PackedInt64Array([0]))
	if c > 0:
		return _big(a.neg, _sub_limbs(a.limbs, b.limbs))
	return _big(b.neg, _sub_limbs(b.limbs, a.limbs))

func _sub(a: Big, b: Big) -> Big:
	return _add(a, _big(not b.neg, b.limbs))

func _mul(a: Big, k: int) -> Big:
	if k == 0:
		return Big.new(false, PackedInt64Array([0]))
	var neg := a.neg
	var m := k
	if m < 0:
		neg = not neg
		m = -m
	return _big(neg, _mul_limbs(a.limbs, m))

func _cmp(a: Big, b: Big) -> int:
	if a.neg != b.neg:
		return -1 if a.neg else 1
	var c := _cmp_limbs(a.limbs, b.limbs)
	return -c if a.neg else c

# floor(a / b) for a >= 0 and b > 0, where the true quotient is known to be at most hi.
# The estimate comes from the two leading limbs of each side, then the magnitude of
# b * est is compared against a and corrected; that needs no big-by-big division.
func _div_quot(a: Big, b: Big, hi: int) -> int:
	var la := a.limbs.size()
	var lb := b.limbs.size()
	if la < lb:
		return 0
	var ta := float(a.limbs[la - 1])
	var tb := float(b.limbs[lb - 1])
	if la >= 2:
		ta = ta * LIMB_BASE + float(a.limbs[la - 2])
	if lb >= 2:
		tb = tb * LIMB_BASE + float(b.limbs[lb - 2])
	var est := hi
	var shift := maxi(la - 2, 0) - maxi(lb - 2, 0)
	if shift <= 2 and tb > 0.0:
		var scale := 1.0
		if shift == 1:
			scale = 1000000000.0
		elif shift == 2:
			scale = 1e18
		var raw := ta / tb * scale
		if raw < 0.0:
			est = 0
		elif raw >= float(hi):
			est = hi
		else:
			est = int(raw)
	while est > 0 and _cmp_limbs(_mul_limbs(b.limbs, est), a.limbs) > 0:
		est -= 1
	while est < hi and _cmp_limbs(_mul_limbs(b.limbs, est + 1), a.limbs) <= 0:
		est += 1
	return est

func _initialize() -> void:
	var q := Big.new(false, PackedInt64Array([1]))
	var r := Big.new(false, PackedInt64Array([0]))
	var t := Big.new(false, PackedInt64Array([1]))
	var k := 1
	var n := 3
	var l := 3
	var total := 0
	var emitted := 0
	while emitted < DIGITS:
		var nt := _mul(t, n)
		# the digit n is settled when 4q + r - t < n * t
		if _cmp(_sub(_add(_mul(q, 4), r), t), nt) < 0:
			total += n
			emitted += 1
			var next_n := _div_quot(_mul(_add(_mul(q, 3), r), 10), t, QUOT_MAX) - 10 * n
			q = _mul(q, 10)
			r = _mul(_sub(r, nt), 10)
			n = next_n
		else:
			var old_q := q
			var old_r := r
			var tl := _mul(t, l)
			n = _div_quot(_add(_mul(old_q, 7 * k + 2), _mul(old_r, l)), tl, QUOT_MAX)
			q = _mul(old_q, k)
			r = _mul(_add(_mul(old_q, 2), old_r), l)
			t = tl
			k += 1
			l += 2
	print(total)
	quit()
