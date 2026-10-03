-- task 03 func_sum — expected output: 100000000
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t03_func_sum
-- run: EIFGENs/t03_func_sum/F_code/prog.exe
-- note: Eiffel has no no-inline attribute, so the helper lives in its own class in its
--       own file, add_one.e, exactly like the Fortran, Tcl, Vala and Oberon-07 rows:
--       the compiler emits one C file per class, and EiffelStudio's
--       MinGW backend does not use link-time optimisation, so the call cannot be folded.
--       Inlining in EiffelStudio is an opt-in advanced option and is left off.
-- note: the helper file cannot be called 03_func_sum_add_one.e the way the other rows
--       name their helpers: an Eiffel class name cannot start with a digit, and the file
--       has to be named after the class it holds.
class
	T03_FUNC_SUM

create
	make

feature -- Benchmark

	make
		local
			value: INTEGER_64
			i: INTEGER_64
			helper: ADD_ONE
		do
			create helper.make

			from
				i := 0
			until
				i >= 100000000
			loop
				value := helper.add_one (value)
				i := i + 1
			end

			io.put_integer_64 (value)
			io.put_new_line
		end

end
