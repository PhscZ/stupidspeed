-- task 15 file_write — expected output: 52428800
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t15_file_write
-- run: EIFGENs/t15_file_write/F_code/prog.exe
-- note: DEVIATION — no fsync. EiffelBase's flush is fflush and the run-time has no
--       fsync/_commit at all, and the library documents the gap itself: "Note that there
--       is no guarantee that the operating system will physically write the data to the
--       disk." The file is therefore flushed and closed, joining the Tcl, D, Julia, Nim,
--       Dart, Pascal, COBOL and Dolphin rows in the RUN.md no-fsync list.
-- note: the 1 MiB buffer is written 50 times with put_managed_pointer, which is the
--       fwrite of the C row; the byte count printed is 50 * 1048576 because the write
--       feature reports no short-write count of its own. The file's size on disk is
--       checked separately, and it is 52428800 bytes.
-- note: out.bin is opened by relative path and lands in the process's working directory,
--       the same convention as the C row: run the executable from the directory you want
--       the file in (sources/eiffel/ for a plain `EIFGENs/t15_file_write/F_code/prog.exe'
--       run).
-- timing: TIME.make_now plus the hour/minute/second/millisecond fields is Eiffel's own
--         clock, read in ss_report and reported as whole milliseconds; io.error is
--         STD_FILES' standard error stream, so TIME_MS goes to stderr and stdout is
--         unchanged. Instrumented by inspection: EiffelStudio is not installed on this
--         machine, so this row's timing is unverified.

class
	T15_FILE_WRITE

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
		local
			f: RAW_FILE
			buffer: MANAGED_POINTER
			written: INTEGER_64
			i, r: INTEGER
		do
			ss_start
			create buffer.make (1048576)
			from
				i := 0
			until
				i >= 1048576
			loop
				buffer.put_natural_8 ((i \\ 256).to_natural_8, i)
				i := i + 1
			end

			create f.make_open_write ("out.bin")
			from
				r := 0
			until
				r >= 50
			loop
				f.put_managed_pointer (buffer, 0, 1048576)
				written := written + 1048576
				r := r + 1
			end

			f.flush
			f.close

			ss_report
			io.put_integer_64 (written)
			io.put_new_line
		end

end
