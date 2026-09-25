# task 03 func_sum — expected output: 100000000
# build: none (interpreted)    run: sourced by 03_func_sum.tcl
# The second file of task 03: add_one is a proc in its own file so the call cannot be
# folded into the caller's body.

proc add_one {n} {
    return [expr {$n + 1}]
}
