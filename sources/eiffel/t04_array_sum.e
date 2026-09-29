-- task 04 array_sum — expected output: 499999500000
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t04_array_sum
-- run: EIFGENs/t04_array_sum/F_code/prog.exe
-- note: SPECIAL [INTEGER_64] is EiffelBase's flat, index-0-based array of unboxed
--       INTEGER_64, so it is the exact counterpart of the C row's int64_t array; the
--       ARRAY class would be 1-based and would hold references.
-- note: the sum 499999500000 does not fit in INTEGER (32 bits), so it is INTEGER_64.
class
	T04_ARRAY_SUM

create
	make

feature -- Benchmark

	make
		local
			a: SPECIAL [INTEGER_64]
			total: INTEGER_64
			i: INTEGER
		do
			create a.make_filled (0, 1000000)

			from
				i := 0
			until
				i >= 1000000
			loop
				a.put (i.to_integer_64, i)
				i := i + 1
			end

			from
				i := 0
			until
				i >= 1000000
			loop
				total := total + a.item (i)
				i := i + 1
			end

			io.put_integer_64 (total)
			io.put_new_line
		end

end
