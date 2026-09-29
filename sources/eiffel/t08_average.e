-- task 08 average — expected output: 0.498046875
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t08_average
-- run: EIFGENs/t08_average/F_code/prog.exe
-- note: the C row prints with %.9f; EiffelBase's REAL_64.out (what put_real_64 writes)
--       is %.17g, which prints the same line here because the average is exactly
--       255 / 512 = 0.498046875 and has an exact 9-digit decimal form.
class
	T08_AVERAGE

create
	make

feature -- Benchmark

	make
		local
			total: REAL_64
			i: INTEGER_64
		do
			from
				i := 0
			until
				i >= 100000000
			loop
				total := total + (i \\ 256).to_double / 256.0
				i := i + 1
			end

			io.put_real_64 (total / 100000000.0)
			io.put_new_line
		end

end
