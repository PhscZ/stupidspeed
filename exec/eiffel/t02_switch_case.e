-- task 02 switch_case — expected output: 7500000075000000
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t02_switch_case
-- run: EIFGENs/t02_switch_case/F_code/prog.exe
-- note: Eiffel has no switch statement; `inspect` is the language's own multi-branch
--       construct and it is what the C row's switch maps onto. The algorithm is the same.
-- note: the total is 7.5e15, far past INTEGER's 2^31, so the accumulator is INTEGER_64.
-- timing: TIME.make_now plus the hour/minute/second/millisecond fields is Eiffel's own
--         clock, read in ss_report and reported as whole milliseconds; io.error is
--         STD_FILES' standard error stream, so TIME_MS goes to stderr and stdout is
--         unchanged. Instrumented by inspection: EiffelStudio is not installed on this
--         machine, so this row's timing is unverified.

class
	T02_SWITCH_CASE

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
			acc: INTEGER_64
			i: INTEGER_64
		do
			ss_start
			from
				i := 0
			until
				i >= 100000000
			loop
				inspect
					i \\ 4
				when 0 then
					acc := acc + 1
				when 1 then
					acc := acc + i
				when 2 then
					acc := acc + 2 * i
				when 3 then
					acc := acc + 3 * i
				end
				i := i + 1
			end

			ss_report
			io.put_integer_64 (acc)
			io.put_new_line
		end

end
