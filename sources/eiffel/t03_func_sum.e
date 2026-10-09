-- task 03 func_sum — expected output: 100000000
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t03_func_sum
-- run: EIFGENs/t03_func_sum/F_code/prog.exe
-- note: Eiffel has no no-inline attribute, so the helper lives in its own class in its
--       own file, add_one.e, exactly like the Fortran, Tcl, Vala and Oberon-07 rows:
--       the compiler emits one C file per class, and EiffelStudio's
--       MinGW backend does not use link-time optimisation, so the call cannot be folded.
--       Inlining in EiffelStudio is an opt-in advanced option and is left off.
-- note: the helper file cannot be called 03_func_sum_add_one.e the way the other rows
--       name their helpers: an Eiffel class name cannot start with a digit, and the file
--       has to be named after the class it holds.
-- timing: TIME.make_now plus the hour/minute/second/millisecond fields is Eiffel's own
--         clock, read in ss_report and reported as whole milliseconds; io.error is
--         STD_FILES' standard error stream, so TIME_MS goes to stderr and stdout is
--         unchanged. Built and run against EiffelStudio 25.12 on this machine, so the timing is real.
--         In 25.12 the TIME class moved to the separate `time` library and its
--         millisecond feature is spelled milli_second, so the ECF pulls in the time
--         library and the sources use that name.

class
	T03_FUNC_SUM

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
			value: INTEGER_64
			i: INTEGER_64
			helper: ADD_ONE
		do
			ss_start
			create helper.make

			from
				i := 0
			until
				i >= 100000000
			loop
				value := helper.add_one (value)
				i := i + 1
			end

			ss_report
			io.put_integer_64 (value)
			io.put_new_line
		end

end
