# task 03 func_sum — expected output: 100000000
# build: none (interpreted)    run: ring 03_func_sum.ring
# note: add_one lives in 03_func_sum_add_one.ring, a real second file. load is executed by
#       the compiler in the parsing stage, so the helper is included at compile time and the
#       function is not defined in this file at all.
# note: Ring has no no-inline marker and needs none: the source is compiled to bytecode and
#       run on the VM, and the VM never inlines a call, so all 100000000 calls are real
#       interpreted calls.
# note: a Ring source file has three sections in order — load lines, top-level statements,
#       functions — so the load is first and the loop follows it.

load "03_func_sum_add_one.ring"

value = 0

for i = 0 to 99999999
    value = add_one(value)
next

? value
