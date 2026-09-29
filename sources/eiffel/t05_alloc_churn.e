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
class
	T05_ALLOC_CHURN

create
	make

feature -- Benchmark

	make
		local
			slots: ARRAY [detachable SPECIAL [NATURAL_8]]
			area: SPECIAL [NATURAL_8]
			total: INTEGER_64
			i: INTEGER_64
			slot: INTEGER
		do
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

			io.put_integer_64 (total)
			io.put_new_line
		end

end
