-- task 11 parallel_sum — expected output: 7500000075000000
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t11_parallel_sum
-- run: EIFGENs/t11_parallel_sum/F_code/prog.exe
-- note: four workers, each a class inheriting EiffelThread's THREAD, launched with
--       `launch' and joined with `join'. EiffelThread maps THREAD onto the platform's
--       native thread library -- Win32 threads on Windows -- so this is real OS
--       threading, the same shape as the C row's CreateThread. The project setting
--       `concurrency` is `thread` for this target only, and the thread library is
--       listed only here.
-- note: the worker class lives in its own file, worker.e (class WORKER), because a class is
--       one file in Eiffel; the target's root is still T11_PARALLEL_SUM.
-- note: EiffelBase is not thread safe, so every worker keeps its state private: one
--       INTEGER_64 attribute for its quarter, one for its partial. The root creates the
--       four objects, launches them, joins them, and sums the four partials afterwards,
--       exactly as the C row sums four Job structs.
-- timing: TIME.make_now plus the hour/minute/second/millisecond fields is Eiffel's own
--         clock, read in ss_report and reported as whole milliseconds; io.error is
--         STD_FILES' standard error stream, so TIME_MS goes to stderr and stdout is
--         unchanged. The counter is read on the root object around the four launches and
--         the four joins. Built and run against EiffelStudio 25.12 on this machine, so the timing is real.
--         In 25.12 the TIME class moved to the separate `time` library and its
--         millisecond feature is spelled milli_second, so the ECF pulls in the time
--         library and the sources use that name.

class
	T11_PARALLEL_SUM

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
			workers: ARRAY [WORKER]
			worker: WORKER
			total: INTEGER_64
			t: INTEGER
		do
			ss_start
			create workers.make (1, 4)

			from
				t := 0
			until
				t >= 4
			loop
				create worker.make (t)
				workers.put (worker, t + 1)
				worker.launch
				t := t + 1
			end

			from
				t := 0
			until
				t >= 4
			loop
				workers.item (t + 1).join
				t := t + 1
			end

			from
				t := 0
			until
				t >= 4
			loop
				total := total + workers.item (t + 1).partial
				t := t + 1
			end

			ss_report
			io.put_integer_64 (total)
			io.put_new_line
		end

end
