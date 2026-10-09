-- task 05 alloc_churn — expected output: 1274991808
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t05_alloc_churn
-- run: EIFGENs/t05_alloc_churn/F_code/prog.exe
-- note: `create area.make_filled (0, 64)` is the malloc(64) of the C row: one 64-byte
--       SPECIAL [NATURAL_8] per iteration. The C row frees the buffer it replaces; the
--       Eiffel row drops it, and the garbage collector (part of the EiffelStudio runtime,
--       as in the C#, Java and Go rows) reclaims it. Keeping the last 256 buffers
--       reachable is what stops the collector from reclaiming the live one.
-- note: the slot array is ARRAY [detachable SPECIAL [NATURAL_8]] because the array is
--       created empty and filled in; ARRAY is 1-based, hence the + 1 on the slot index.
-- note: the total is 1274991808, past INTEGER's 2^31, so it is INTEGER_64.
-- timing: TIME.make_now plus the hour/minute/second/millisecond fields is Eiffel's own
--         clock, read in ss_report and reported as whole milliseconds; io.error is
--         STD_FILES' standard error stream, so TIME_MS goes to stderr and stdout is
--         unchanged. Built and run against EiffelStudio 25.12 on this machine, so the timing is real.
--         In 25.12 the TIME class moved to the separate `time` library and its
--         millisecond feature is spelled milli_second, so the ECF pulls in the time
--         library and the sources use that name.

class
	T05_ALLOC_CHURN

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
			slots: ARRAY [detachable SPECIAL [NATURAL_8]]
			area: SPECIAL [NATURAL_8]
			total: INTEGER_64
			i: INTEGER_64
			slot: INTEGER
		do
			ss_start
			create slots.make_filled (Void, 1, 256)

			from
				i := 0
			until
				i >= 10000000
			loop
				create area.make_filled (0, 64)
				area.put ((i \\ 256).to_natural_8, 0)
				total := total + area.item (0).to_integer_64

				slot := (i \\ 256).to_integer
				slots.put (area, slot + 1)
				i := i + 1
			end

			ss_report
			io.put_integer_64 (total)
			io.put_new_line
		end

end
