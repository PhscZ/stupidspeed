-- task 07 string_append — expected output: 250000
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t07_string_append
-- run: EIFGENs/t07_string_append/F_code/prog.exe
-- note: DEVIATION, and an honest one. Eiffel's STRING_8 is a growable buffer, not an
--       immutable string type, so `append_character` does not rebuild the string the way
--       the C row's realloc + strcat does: STRING_8.append_character calls
--       resize (count + additional_space), and RESIZABLE.additional_space is
--       (capacity // 2).max (Minimal_increase) -- 50% geometric growth. The loop is
--       therefore amortised O(1), not quadratic, and this cell measures an optimised
--       append rather than the quadratic copy the task is designed to measure. Recorded
--       the same way the Raku and Erlang rows record their string types.
-- note: `create text.make_empty` starts from zero capacity so the growth policy really
--       is what runs; the count printed is STRING_8.count.
-- timing: TIME.make_now plus the hour/minute/second/millisecond fields is Eiffel's own
--         clock, read in ss_report and reported as whole milliseconds; io.error is
--         STD_FILES' standard error stream, so TIME_MS goes to stderr and stdout is
--         unchanged. Built and run against EiffelStudio 25.12 on this machine, so the timing is real.
--         In 25.12 the TIME class moved to the separate `time` library and its
--         millisecond feature is spelled milli_second, so the ECF pulls in the time
--         library and the sources use that name.

class
	T07_STRING_APPEND

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
			text: STRING_8
			i: INTEGER
		do
			ss_start
			create text.make_empty

			from
				i := 0
			until
				i >= 250000
			loop
				text.append_character ('x')
				i := i + 1
			end

			ss_report
			io.put_integer (text.count)
			io.put_new_line
		end

end
