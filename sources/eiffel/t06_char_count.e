-- task 06 char_count — expected output: 10000000
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t06_char_count
-- run: EIFGENs/t06_char_count/F_code/prog.exe
-- note: the whole 100 MB text is built up front, block by block, exactly as the C row
--       memcpy's the 10-byte block 10 million times. STRING_8 is pre-sized with
--       `make (100000000)` so the append loop never grows the buffer and task 06 does
--       not measure task 07's reallocation behaviour.
-- note: only 'h' is counted; the specification's "skipping 'a' and 'e'" is the same test.
-- timing: TIME.make_now plus the hour/minute/second/millisecond fields is Eiffel's own
--         clock, read in ss_report and reported as whole milliseconds; io.error is
--         STD_FILES' standard error stream, so TIME_MS goes to stderr and stdout is
--         unchanged. Built and run against EiffelStudio 25.12 on this machine, so the timing is real.
--         In 25.12 the TIME class moved to the separate `time` library and its
--         millisecond feature is spelled milli_second, so the ECF pulls in the time
--         library and the sources use that name.

class
	T06_CHAR_COUNT

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
			block: STRING_8
			count: INTEGER_64
			i: INTEGER
		do
			ss_start
			create text.make (100000000)
			block := "abcdefghij"

			from
				i := 0
			until
				i >= 10000000
			loop
				text.append (block)
				i := i + 1
			end

			from
				i := 1
			until
				i > text.count
			loop
				if text.item (i) = 'h' then
					count := count + 1
				end
				i := i + 1
			end

			ss_report
			io.put_integer_64 (count)
			io.put_new_line
		end

end
