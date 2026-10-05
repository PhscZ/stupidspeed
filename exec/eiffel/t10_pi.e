-- task 10 pi — expected output: 4470
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t10_pi
-- run: EIFGENs/t10_pi/F_code/prog.exe
-- note: EiffelBase has no arbitrary-precision integer (the ELKS kernel cluster holds only
--       INTEGER_8/16/32/64, NATURAL_* and REAL_*), so the spigot's state is hand-rolled
--       in big.e, sign-magnitude little-endian INTEGER_64 limbs, base 1e9 -- the same
--       arithmetic the C row implements in sources/c/10_pi.c. The digits themselves are
--       never printed, only their sum, exactly like the C row.
-- timing: TIME.make_now plus the hour/minute/second/millisecond fields is Eiffel's own
--         clock, read in ss_report and reported as whole milliseconds; io.error is
--         STD_FILES' standard error stream, so TIME_MS goes to stderr and stdout is
--         unchanged. Instrumented by inspection: EiffelStudio is not installed on this
--         machine, so this row's timing is unverified.

class
	T10_PI

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
			-- Gibbons' unbounded spigot, 1000 digits of pi.
		local
			q, r, t, u, v, w: BIG
			k, l, n, sum, next: INTEGER_64
			produced: INTEGER
		do
			ss_start
			create q.make
			create r.make
			create t.make
			create u.make
			create v.make
			create w.make

			q.set_from_integer_64 (1)
			r.set_from_integer_64 (0)
			t.set_from_integer_64 (1)

			k := 1
			l := 3
			n := 3

			from
				produced := 0
			until
				produced >= 1000
			loop
				u.mul_small_from (q, 4)
				u.add_from (u, r)
				v.mul_small_from (t, n + 1)

				if u.compare (v) < 0 then
					-- the digit n is settled
					sum := sum + n
					produced := produced + 1

					u.mul_small_from (q, 3)
					u.add_from (u, r)
					u.mul_small_from (u, 10)
					next := u.quotient (t, w) - 10 * n

					v.mul_small_from (t, n)
					v.sub_from (r, v)
					r.mul_small_from (v, 10)
					q.mul_small_from (q, 10)

					n := next
				else
					-- not settled yet: widen the state by one more term
					u.mul_small_from (q, 7 * k + 2)
					v.mul_small_from (r, l)
					u.add_from (u, v)
					v.mul_small_from (t, l)
					next := u.quotient (v, w)

					u.mul_small_from (q, 2)
					u.add_from (u, r)
					u.mul_small_from (u, l)
					r.copy_from (u)
					q.mul_small_from (q, k)
					t.mul_small_from (t, l)

					k := k + 1
					l := l + 2
					n := next
				end
			end

			ss_report
			io.put_integer_64 (sum)
			io.put_new_line
		end

end
