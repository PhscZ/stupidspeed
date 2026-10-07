# task 03 func_sum — expected output: 100000000
# build: none (interpreted)    run: loaded by 03_func_sum.ring
# The second file of task 03: add_one lives in its own file, and load is executed by the
# compiler at parse time, so the function is not defined in 03_func_sum.ring at all. Ring
# has no no-inline marker and needs none — the VM is a bytecode interpreter and never
# inlines a call, so all 100000000 calls are real interpreted calls.

func add_one n
    return n + 1
