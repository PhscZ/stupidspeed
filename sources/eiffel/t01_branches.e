-- task 01 branches — expected output: 33333334 13333333 7619048 45714285
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t01_branches
-- run: EIFGENs/t01_branches/F_code/prog.exe
-- note: the file is t01_branches.e and not 01_branches.e because an Eiffel class name
--       is an identifier and cannot start with a digit, and by convention the file is
--       named after the class it holds (the Ada row's t01_branches.adb does the same).
-- note: INTEGER is 32 bits, so the four counters are INTEGER_64 like the C row's int64_t.
class
	T01_BRANCHES

create
	make

feature -- Benchmark

	make
		local
			a, b, c, d: INTEGER_64
			i: INTEGER_64
		do
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
