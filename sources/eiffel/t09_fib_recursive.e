-- task 09 fib_recursive — expected output: 102334155
-- build: ec -batch -finalize -c_compile -config stupidspeed.ecf -target t09_fib_recursive
-- run: EIFGENs/t09_fib_recursive/F_code/prog.exe
-- note: a plain recursive feature, no memoization, exactly the C row's fib.
class
	T09_FIB_RECURSIVE

create
	make

feature -- Benchmark

	make
		do
			io.put_integer_64 (fib (40))
			io.put_new_line
		end

feature -- Access

	fib (n: INTEGER): INTEGER_64
			-- The n-th Fibonacci number, naively.
		do
			if n < 2 then
				Result := n.to_integer_64
			else
				Result := fib (n - 1) + fib (n - 2)
			end
		end

end
