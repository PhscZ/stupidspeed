-- task 09 fib_recursive — expected output: 102334155
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t09_fib_recursive
-- run: EIFGENs/t09_fib_recursive/F_code/prog.exe
-- note: a plain recursive feature, no memoization, exactly the C row's fib.
-- timing: TIME.make_now plus the hour/minute/second/millisecond fields is Eiffel's own
--         clock, read in ss_report and reported as whole milliseconds; io.error is
--         STD_FILES' standard error stream, so TIME_MS goes to stderr and stdout is
--         unchanged. Instrumented by inspection: EiffelStudio is not installed on this
--         machine, so this row's timing is unverified.

class
	T09_FIB_RECURSIVE

create
	make

feature -- Benchmark

	ss_t0: TIME

	ss_value: INTEGER_64

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
		do
			ss_start
			ss_value := fib (40)
			ss_report
			io.put_integer_64 (ss_value)
			io.put_new_line
		end

feature -- Access

	fib (n: INTEGER): INTEGER_64
			-- The n-th Fibonacci number, naively.
		do
			if n < 2 then
				Result := n.to_integer_64
			else
				Result := fib (n - 1) + fib (n - 2)
			end
		end

end
