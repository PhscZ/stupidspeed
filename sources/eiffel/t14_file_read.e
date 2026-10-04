-- task 14 file_read — expected output: 2389704704
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t14_file_read
-- run: EIFGENs/t14_file_read/F_code/prog.exe
-- note: 1 MiB at a time, as README.md requires; the inner per-byte accumulation loop is
--       the loop the task is about. read_to_managed_pointer fills a MANAGED_POINTER and
--       leaves the count read in bytes_read, which is the fread + return-count of the C
--       row. RAW_FILE opens in binary mode on Windows (the runtime passes 'b' to fopen),
--       so no text-mode translation happens.
-- note: data.bin is opened by relative path, and the Eiffel run-time resolves that against
--       the process's working directory, exactly like the C row: run the executable from a
--       directory that holds data.bin (copy it into sources/eiffel/ and run
--       EIFGENs/t14_file_read/F_code/prog.exe from there). Verified by moving the
--       executable away from its F_code directory: with data.bin in the working directory
--       it still prints the right line, and with data.bin only next to the executable it
--       fails to open it.
-- note: no fsync here, but the read path is unaffected; see t15_file_write.e.
-- timing: TIME.make_now plus the hour/minute/second/millisecond fields is Eiffel's own
--         clock, read in ss_report and reported as whole milliseconds; io.error is
--         STD_FILES' standard error stream, so TIME_MS goes to stderr and stdout is
--         unchanged. Instrumented by inspection: EiffelStudio is not installed on this
--         machine, so this row's timing is unverified.

class
	T14_FILE_READ

create
	make

feature -- Benchmark

	ss_t0: TIME

	ss_now_ms (t: TIME): INTEGER_64
		do
			Result := (((t.hour * 60) + t.minute) * 60 + t.second) * 1000 + t.millisecond
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
			f: RAW_FILE
			buffer: MANAGED_POINTER
			total: INTEGER_64
			got, i: INTEGER
		do
			ss_start
			create buffer.make (1048576)
			create f.make_open_read ("data.bin")

			from
				f.read_to_managed_pointer (buffer, 0, 1048576)
				got := f.bytes_read
			until
				got <= 0
			loop
				from
					i := 0
				until
					i >= got
				loop
					total := total + buffer.read_natural_8 (i).to_integer_64
					i := i + 1
				end
				f.read_to_managed_pointer (buffer, 0, 1048576)
				got := f.bytes_read
			end

			f.close

			ss_report
			io.put_integer_64 (total \\ 4294967296)
			io.put_new_line
		end

end
