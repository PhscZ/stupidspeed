-- task 01 branches — expected output: 33333334 13333333 7619048 45714285
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t01_branches
-- run: EIFGENs/t01_branches/F_code/prog.exe
-- note: the file is t01_branches.e and not 01_branches.e because an Eiffel class name
--       is an identifier and cannot start with a digit, and by convention the file is
--       named after the class it holds (the Ada row's t01_branches.adb does the same).
-- note: INTEGER is 32 bits, so the four counters are INTEGER_64 like the C row's int64_t.
-- timing: TIME.make_now plus the hour/minute/second/millisecond fields is Eiffel's own
--         clock, read in ss_report and reported as whole milliseconds; io.error is
--         STD_FILES' standard error stream, so TIME_MS goes to stderr and stdout is
--         unchanged. Instrumented by inspection: EiffelStudio is not installed on this
--         machine, so this row's timing is unverified.

class
	T01_BRANCHES

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
			a, b, c, d: INTEGER_64
			i: INTEGER_64
		do
			ss_start
			from
				i := 0
			until
				i >= 100000000
			loop
				if i \\ 3 = 0 then
					a := a + 1
				elseif i \\ 5 = 0 then
					b := b + 1
				elseif i \\ 7 = 0 then
					c := c + 1
				else
					d := d + 1
				end
				i := i + 1
			end

			ss_report
			io.put_integer_64 (a)
			io.put_character (' ')
			io.put_integer_64 (b)
			io.put_character (' ')
			io.put_integer_64 (c)
			io.put_character (' ')
			io.put_integer_64 (d)
			io.put_new_line
		end

end
