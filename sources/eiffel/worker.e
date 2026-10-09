-- task 11 parallel_sum worker — one quarter of task 02's switch, run on its own OS
-- thread. Four of these are launched by T11_PARALLEL_SUM, one per quarter.
class
	WORKER

inherit
	THREAD
		rename
			make as thread_make
		end

create
	make

feature -- Initialization

	make (t: INTEGER)
			-- Prepare the worker that owns quarter t.
		do
			thread_make
			index := t
		end

feature -- Access

	partial: INTEGER_64
			-- The worker's result, valid once `join' has returned.

feature -- Basic operations

	execute
			-- Task 02's switch over [index * 25000000, (index + 1) * 25000000).
		local
			acc: INTEGER_64
			i: INTEGER_64
			lo, hi: INTEGER_64
		do
			lo := index.to_integer_64 * 25000000
			hi := lo + 25000000

			from
				i := lo
			until
				i >= hi
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

			partial := acc
		end

feature {NONE} -- Implementation

	index: INTEGER
			-- Which quarter this worker owns.

end
