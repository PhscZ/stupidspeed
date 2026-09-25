// task 09 fib_recursive — expected output: 102334155
// build: v -prod -cc gcc -o prog 09_fib_recursive.v    run: ./prog
// note: naive double recursion, no memoisation.

module main

fn fib(n i64) i64 {
	if n < 2 {
		return n
	}
	return fib(n - 1) + fib(n - 2)
}

fn main() {
	println(fib(40))
}
