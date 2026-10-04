-- task 08 average — expected output: 0.498046875
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t08_average
-- run: EIFGENs/t08_average/F_code/prog.exe
-- note: the C row prints with %.9f; EiffelBase's REAL_64.out (what put_real_64 writes)
--       is %.17g, which prints the same line here because the average is exactly
--       255 / 512 = 0.498046875 and has an exact 9-digit decimal form.
-- timing: TIME.make_now plus the hour/minute/second/millisecond fields is Eiffel's own
--         clock, read in ss_report and reported as whole milliseconds; io.error is
--         STD_FILES' standard error stream, so TIME_MS goes to stderr and stdout is
--         unchanged. Instrumented by inspection: EiffelStudio is not installed on this
--         machine, so this row's timing is unverified.

class
	T08_AVERAGE

create
	make

feature -- Benchmark

	ss_t0: TIME

	ss_now_ms (t: TIME): INTEGER_64
		do
			Result := (((t.hour * 60) + t.minute) * 60 + t.second) * 1000 + t.millisecond
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
			total: REAL_64
			i: INTEGER_64
		do
			ss_start
			from
				i := 0
			until
				i >= 100000000
			loop
				total := total + (i \\ 256).to_double / 256.0
				i := i + 1
			end

			ss_report
			io.put_real_64 (total / 100000000.0)
			io.put_new_line
		end

end
