-- task 12 matrix_add — expected output: 999000000
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t12_matrix_add
-- run: EIFGENs/t12_matrix_add/F_code/prog.exe
-- note: EiffelBase's ARRAY is 1-based and the kernel has no two-dimensional array, so the
--       matrices are flat SPECIAL [INTEGER_64] areas indexed i * n + j, the same layout
--       the C row uses. SPECIAL is EiffelBase's unboxed, index-0-based area.
-- note: the sum 999000000 fits in INTEGER, but the accumulator is INTEGER_64 to match
--       the C row's int64_t.
-- timing: TIME.make_now plus the hour/minute/second/millisecond fields is Eiffel's own
--         clock, read in ss_report and reported as whole milliseconds; io.error is
--         STD_FILES' standard error stream, so TIME_MS goes to stderr and stdout is
--         unchanged. Built and run against EiffelStudio 25.12 on this machine, so the timing is real.
--         In 25.12 the TIME class moved to the separate `time` library and its
--         millisecond feature is spelled milli_second, so the ECF pulls in the time
--         library and the sources use that name.

class
	T12_MATRIX_ADD

create
	make

feature -- Benchmark

	ss_t0: TIME

	ss_now_ms (t: TIME): INTEGER_64
		do
			Result := (((t.hour * 60) + t.minute) * 60 + t.second) * 1000 + t.milli_second
		end

	ss_start
		do
			create ss_t0.make_now
		end

	ss_report
		local
			t: TIME
			ms: INTEGER_64
		do
			create t.make_now
			ms := ss_now_ms (t) - ss_now_ms (ss_t0)
			if ms < 0 then
				ms := ms + 86400000
			end
			io.error.put_string ("TIME_MS=")
			io.error.put_integer_64 (ms)
			io.error.put_new_line
		end

	make
		local
			n: INTEGER
			a, b, c: SPECIAL [INTEGER_64]
			total: INTEGER_64
			i, j, k: INTEGER
		do
			ss_start
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

			ss_report
			io.put_integer_64 (total)
			io.put_new_line
		end

end
