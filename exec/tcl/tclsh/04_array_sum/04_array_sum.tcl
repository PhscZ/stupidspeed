# task 04 array_sum — expected output: 499999500000
# build: none (interpreted)    run: tclsh 04_array_sum.tcl
# A Tcl list of a million integers, filled and then walked in order.

set __t0 [clock microseconds]
set arr [lrepeat 1000000 0]
for {set i 0} {$i < 1000000} {incr i} {
    lset arr $i $i
}

set total 0
for {set i 0} {$i < 1000000} {incr i} {
    incr total [lindex $arr $i]
}

set __t1 [clock microseconds]
puts stderr [format "TIME_MS=%.3f" [expr {($__t1 - $__t0) / 1000.0}]]
puts $total
