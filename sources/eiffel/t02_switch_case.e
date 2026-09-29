-- task 02 switch_case — expected output: 7500000075000000
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t02_switch_case
-- run: EIFGENs/t02_switch_case/F_code/prog.exe
-- note: Eiffel has no switch statement; `inspect` is the language's own multi-branch
--       construct and it is what the C row's switch maps onto. The algorithm is the same.
-- note: the total is 7.5e15, far past INTEGER's 2^31, so the accumulator is INTEGER_64.
class
	T02_SWITCH_CASE

create
	make

feature -- Benchmark

	make
		local
			acc: INTEGER_64
			i: INTEGER_64
		do
			from
				i := 0
			until
				i >= 100000000
			loop
				inspect
					i \\ 4
				when 0 then
					acc := acc + 1
				when 1 then
					acc := acc + i
				when 2 then
					acc := acc + 2 * i
				when 3 then
					acc := acc + 3 * i
				end
				i := i + 1
			end

			io.put_integer_64 (acc)
			io.put_new_line
		end

end
