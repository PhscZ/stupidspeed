-- task 10 pi helper — hand-rolled arbitrary-precision integers, the Eiffel counterpart of
-- the Big struct in sources/c/10_pi.c: sign-magnitude, little-endian INTEGER_64 limbs,
-- base 1e9. Only the operations Gibbons' spigot needs are here: add, subtract, multiply
-- by a small integer (limb * small + carry stays well inside INTEGER_64) and a quotient,
-- which is always one decimal digit and so comes out of repeated subtraction.
-- note: EiffelBase has no arbitrary-precision integer, so the row hand-rolls the limbs
--       exactly as the C row does; this file is a second helper class, like add_one.e.
class
	BIG

create
	make

feature -- Initialization

	make
			-- An empty (zero) value with room for eight limbs.
		do
			capacity := 8
			create limbs.make_filled (0, capacity)
		end

feature -- Status report

	compare (other: BIG): INTEGER
			-- -1, 0 or 1 as Current is smaller, equal to or greater than other.
		do
			if negative /= other.negative then
				Result := (if negative then -1 else 1 end)
			else
				Result := compare_mag (other)
				if negative then
					Result := -Result
				end
			end
		end

	compare_mag (other: BIG): INTEGER
			-- -1, 0 or 1 comparing the magnitudes.
		local
			i: INTEGER
		do
			if count /= other.count then
				Result := (if count < other.count then -1 else 1 end)
			else
				from
					i := count
				until
					i <= 0 or Result /= 0
				loop
					i := i - 1
					if limbs.item (i) /= other.limbs.item (i) then
						Result := (if limbs.item (i) < other.limbs.item (i) then -1 else 1 end)
					end
				end
			end
		end

feature -- Element change

	set_from_integer_64 (v: INTEGER_64)
			-- Make Current the value v, which must not be negative.
		local
			value: INTEGER_64
		do
			count := 0
			negative := False
			from
				value := v
			until
				value <= 0
			loop
				reserve (count + 1)
				limbs.put (value \\ base, count)
				count := count + 1
				value := value // base
			end
		end

	copy_from (src: BIG)
			-- Make Current a copy of src.
		local
			i: INTEGER
		do
			reserve (src.count)
			if src.count > 0 then
				from
					i := 0
				until
					i >= src.count
				loop
					limbs.put (src.limbs.item (i), i)
					i := i + 1
				end
			end
			count := src.count
			negative := src.negative
		end

	add_from (a, b: BIG)
			-- Make Current a + b.
		local
			a_negative, b_negative: BOOLEAN
		do
			a_negative := a.negative
			b_negative := b.negative
			if a_negative = b_negative then
				add_mag_from (a, b)
				negative := a_negative
			elseif a.compare_mag (b) >= 0 then
				sub_mag_from (a, b)
				negative := a_negative
			else
				sub_mag_from (b, a)
				negative := b_negative
			end
			trim
		end

	sub_from (a, b: BIG)
			-- Make Current a - b.
		local
			a_negative, b_negative: BOOLEAN
		do
			a_negative := a.negative
			b_negative := b.negative
			if a_negative /= b_negative then
				add_mag_from (a, b)
				negative := a_negative
			elseif a.compare_mag (b) >= 0 then
				sub_mag_from (a, b)
				negative := a_negative
			else
				sub_mag_from (b, a)
				negative := not a_negative
			end
			trim
		end

	mul_small_from (a: BIG; m: INTEGER_64)
			-- Make Current a * m, for a small non-negative m.
		local
			carry, product: INTEGER_64
			i, nn: INTEGER
		do
			if m = 0 or a.count = 0 then
				count := 0
				negative := False
			else
				reserve (a.count + 2)
				carry := 0
				from
					i := 0
				until
					i >= a.count
				loop
					product := a.limbs.item (i) * m + carry
					limbs.put (product \\ base, i)
					carry := product // base
					i := i + 1
				end
				nn := a.count
				from
				until
					carry <= 0
				loop
					limbs.put (carry \\ base, nn)
					carry := carry // base
					nn := nn + 1
				end
				count := nn
				negative := a.negative
				trim
			end
		end

feature -- Access

	quotient (b, work: BIG): INTEGER_64
			-- floor (Current / b) for Current >= 0 and b > 0. The spigot only ever asks
			-- for a quotient of one decimal digit, so counting how many times b fits
			-- into Current is enough. work is scratch space supplied by the caller.
		do
			if negative or b.negative or b.count = 0 then
				Result := 0
			else
				work.copy_from (b)
				from
				until
					compare (work) < 0
				loop
					Result := Result + 1
					work.add_mag_from (work, b)
				end
			end
		end

feature {BIG} -- Implementation

	limbs: SPECIAL [INTEGER_64]
			-- Little-endian base-1e9 limbs. Its count always equals capacity, so any
			-- slot below capacity can be written; only the first `count' limbs below
			-- are meaningful.

	count: INTEGER
			-- Number of limbs in use, without leading zeros.

	capacity: INTEGER
			-- Number of limbs allocated.

	negative: BOOLEAN
			-- Is the value negative?

	base: INTEGER_64 = 1000000000

	reserve (need: INTEGER)
			-- Make sure there is room for need limbs, doubling the capacity if not.
		do
			if need > capacity then
				from
				until
					capacity >= need
				loop
					capacity := capacity * 2
				end
				limbs := limbs.resized_area_with_default (0, capacity)
			end
		end

	trim
			-- Drop leading zero limbs; zero is not negative.
		do
			from
			until
				count = 0 or limbs.item (count - 1) /= 0
			loop
				count := count - 1
			end
			if count = 0 then
				negative := False
			end
		end

	add_mag_from (a, b: BIG)
			-- Make Current |a| + |b|.
		local
			carry, s: INTEGER_64
			i, nn: INTEGER
		do
			nn := a.count.max (b.count)
			reserve (nn + 1)
			carry := 0
			from
				i := 0
			until
				i >= nn
			loop
				s := carry
				if i < a.count then
					s := s + a.limbs.item (i)
				end
				if i < b.count then
					s := s + b.limbs.item (i)
				end
				if s >= base then
					s := s - base
					carry := 1
				else
					carry := 0
				end
				limbs.put (s, i)
				i := i + 1
			end
			limbs.put (carry, nn)
			count := nn
			if carry > 0 then
				count := nn + 1
			end
			negative := False
		end

	sub_mag_from (a, b: BIG)
			-- Make Current |a| - |b|; requires |a| >= |b|.
		local
			borrow, bi: INTEGER_64
			i: INTEGER
		do
			reserve (a.count)
			borrow := 0
			from
				i := 0
			until
				i >= a.count
			loop
				bi := borrow
				if i < b.count then
					bi := bi + b.limbs.item (i)
				end
				if a.limbs.item (i) >= bi then
					limbs.put (a.limbs.item (i) - bi, i)
					borrow := 0
				else
					limbs.put (a.limbs.item (i) + base - bi, i)
					borrow := 1
				end
				i := i + 1
			end
			count := a.count
			negative := False
			trim
		end

end
