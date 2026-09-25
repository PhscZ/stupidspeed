# task 04 array_sum — expected output: 499999500000
# build: none (interpreted)    run: tclsh 04_array_sum.tcl
# A Tcl list of a million integers, filled and then walked in order.

set arr [lrepeat 1000000 0]
for {set i 0} {$i < 1000000} {incr i} {
    lset arr $i $i
}

set total 0
for {set i 0} {$i < 1000000} {incr i} {
    incr total [lindex $arr $i]
}

puts $total
