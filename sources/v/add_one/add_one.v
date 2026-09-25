// task 03 func_sum — expected output: 100000000
// build: v -prod -cc gcc -o prog 03_func_sum.v    run: ./prog
// the second file of task 03: add_one lives in its own module so the call is real.
// V compiles `v 03_func_sum.v` as that file plus the modules it imports, so this
// subdirectory does not disturb the other fourteen tasks in this folder.

module add_one

// noinline keeps the call alive even though the body is one addition; it is the
// V equivalent of the __attribute__((noinline)) the C reference uses.
@[noinline]
pub fn add_one(n i64) i64 {
	return n + 1
}
