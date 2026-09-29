-- task 06 char_count — expected output: 10000000
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t06_char_count
-- run: EIFGENs/t06_char_count/F_code/prog.exe
-- note: the whole 100 MB text is built up front, block by block, exactly as the C row
--       memcpy's the 10-byte block 10 million times. STRING_8 is pre-sized with
--       `make (100000000)` so the append loop never grows the buffer and task 06 does
--       not measure task 07's reallocation behaviour.
-- note: only 'h' is counted; the specification's "skipping 'a' and 'e'" is the same test.
class
	T06_CHAR_COUNT

create
	make

feature -- Benchmark

	make
		local
			text: STRING_8
			block: STRING_8
			count: INTEGER_64
			i: INTEGER
		do
			create text.make (100000000)
			block := "abcdefghij"

			from
				i := 0
			until
				i >= 10000000
			loop
				text.append (block)
				i := i + 1
			end

			from
				i := 1
			until
				i > text.count
			loop
				if text.item (i) = 'h' then
					count := count + 1
				end
				i := i + 1
			end

			io.put_integer_64 (count)
			io.put_new_line
		end

end
