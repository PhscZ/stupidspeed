// task 03 func_sum — expected output: 100000000
// build: none (interpreted)    run: lobster 03_func_sum.lobster
//
// Lobster inlines ordinary function calls aggressively, so add_one is a function
// value passed through a parameter of an explicitly declared function type: the docs
// say using a function type "forces the function passed to not be inlined".  That
// leaves a real indirect call each iteration, the closest Lobster has to C's
// __attribute__((noinline)).

// timing: seconds_elapsed() is the VM's monotonic clock (QueryPerformanceCounter on Windows).
// Lobster has no stderr, so the contract's fallback applies: TIME_MS is written to time.txt.
let t_start = seconds_elapsed()

def int_fn(i:int) -> int

def call_it(f:int_fn, n:int) -> int: return f(n)

let add_one = fn(n:int): n + 1

var value = 0

for(100000000):
    value = call_it(add_one, value)

write_file("time.txt", "TIME_MS=" + string((seconds_elapsed() - t_start) * 1000.0) + "\n")
print value
