-- task 13 matrix_mul — expected output: 599995000
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t13_matrix_mul
-- run: EIFGENs/t13_matrix_mul/F_code/prog.exe
-- note: flat SPECIAL [INTEGER_64] areas indexed i * n + j, as in task 12. The plain i, j, k
--       triple loop is kept in that order; no blocking, no transposition, no SIMD.
-- note: every value here fits in INTEGER (A entries 0..6, B entries 0..4, one C entry at
--       most 500 * 24), but the cells and the accumulator are INTEGER_64 to match the C
--       row's int64_t.
class
	T13_MATRIX_MUL

create
	make

feature -- Benchmark

	make
		local
			n: INTEGER
			a, b, c: SPECIAL [INTEGER_64]
			total, sum: INTEGER_64
			i, j, k: INTEGER
		do
			n := 500
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
					a.put (((i + j) \\ 7).to_integer_64, i * n + j)
					b.put (((i * j) \\ 5).to_integer_64, i * n + j)
					j := j + 1
				end
				i := i + 1
			end

			-- plain i, j, k triple loop, in that order
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
					sum := 0
					from
						k := 0
					until
						k >= n
					loop
						sum := sum + a.item (i * n + k) * b.item (k * n + j)
						k := k + 1
					end
					c.put (sum, i * n + j)
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
