# task 03 func_sum — expected output: 100000000
# build: none (interpreted)    run: tclsh 03_func_sum.tcl
# add_one lives in its own file (03_func_sum_add_one.tcl) and is sourced, so the call
# is a real cross-file procedure call. Tcl has no no-inline marker; a proc call is a
# hash-table lookup and a new call frame every time, which is the overhead measured.

source [file join [file dirname [info script]] 03_func_sum_add_one.tcl]

set value 0

for {set i 0} {$i < 100000000} {incr i} {
    set value [add_one $value]
}

puts $value
