-- task 04 array_sum — expected output: 499999500000
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t04_array_sum
-- run: EIFGENs/t04_array_sum/F_code/prog.exe
-- note: SPECIAL [INTEGER_64] is EiffelBase's flat, index-0-based array of unboxed
--       INTEGER_64, so it is the exact counterpart of the C row's int64_t array; the
--       ARRAY class would be 1-based and would hold references.
-- note: the sum 499999500000 does not fit in INTEGER (32 bits), so it is INTEGER_64.
-- timing: TIME.make_now plus the hour/minute/second/millisecond fields is Eiffel's own
--         clock, read in ss_report and reported as whole milliseconds; io.error is
--         STD_FILES' standard error stream, so TIME_MS goes to stderr and stdout is
--         unchanged. Instrumented by inspection: EiffelStudio is not installed on this
--         machine, so this row's timing is unverified.

class
	T04_ARRAY_SUM

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
			a: SPECIAL [INTEGER_64]
			total: INTEGER_64
			i: INTEGER
		do
			ss_start
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

			ss_report
			io.put_integer_64 (total)
			io.put_new_line
		end

end
