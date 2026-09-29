-- task 07 string_append — expected output: 1000000
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t07_string_append
-- run: EIFGENs/t07_string_append/F_code/prog.exe
-- note: DEVIATION, and an honest one. Eiffel's STRING_8 is a growable buffer, not an
--       immutable string type, so `append_character` does not rebuild the string the way
--       the C row's realloc + strcat does: STRING_8.append_character calls
--       resize (count + additional_space), and RESIZABLE.additional_space is
--       (capacity // 2).max (Minimal_increase) -- 50% geometric growth. The loop is
--       therefore amortised O(1), not quadratic, and this cell measures an optimised
--       append rather than the quadratic copy the task is designed to measure. Recorded
--       the same way the Raku and Erlang rows record their string types.
-- note: `create text.make_empty` starts from zero capacity so the growth policy really
--       is what runs; the count printed is STRING_8.count.
class
	T07_STRING_APPEND

create
	make

feature -- Benchmark

	make
		local
			text: STRING_8
			i: INTEGER
		do
			create text.make_empty

			from
				i := 0
			until
				i >= 1000000
			loop
				text.append_character ('x')
				i := i + 1
			end

			io.put_integer (text.count)
			io.put_new_line
		end

end
