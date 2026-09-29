-- task 12 matrix_add — expected output: 999000000
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t12_matrix_add
-- run: EIFGENs/t12_matrix_add/F_code/prog.exe
-- note: EiffelBase's ARRAY is 1-based and the kernel has no two-dimensional array, so the
--       matrices are flat SPECIAL [INTEGER_64] areas indexed i * n + j, the same layout
--       the C row uses. SPECIAL is EiffelBase's unboxed, index-0-based area.
-- note: the sum 999000000 fits in INTEGER, but the accumulator is INTEGER_64 to match
--       the C row's int64_t.
class
	T12_MATRIX_ADD

create
	make

feature -- Benchmark

	make
		local
			n: INTEGER
			a, b, c: SPECIAL [INTEGER_64]
			total: INTEGER_64
			i, j, k: INTEGER
		do
			n := 1000
			create a.make_filled (0, n * n)
			create b.make_filled (0, n * n)
			create c.make_filled (0, n * n)

			from
				i := 0
			until
				i >= n
			loop
				from
					j := 0
				until
					j >= n
				loop
					a.put ((i + j).to_integer_64, i * n + j)
					b.put ((i - j).to_integer_64, i * n + j)
					j := j + 1
				end
				i := i + 1
			end

			from
				i := 0
			until
				i >= n
			loop
				from
					j := 0
				until
					j >= n
				loop
					c.put (a.item (i * n + j) + b.item (i * n + j), i * n + j)
					j := j + 1
				end
				i := i + 1
			end

			from
				k := 0
			until
				k >= n * n
			loop
				total := total + c.item (k)
				k := k + 1
			end

			io.put_integer_64 (total)
			io.put_new_line
		end

end
