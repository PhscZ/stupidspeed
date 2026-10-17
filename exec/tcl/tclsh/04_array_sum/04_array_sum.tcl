# task 04 array_sum — expected output: 599999940000000
# build: none (interpreted)    run: tclsh 04_array_sum.tcl
# A Tcl list of ten million integers, filled once and then walked twelve times.

set __t0 [clock microseconds]
set arr [lrepeat 10000000 0]
for {set i 0} {$i < 10000000} {incr i} {
    lset arr $i $i
}

set total 0
for {set pass 0} {$pass < 12} {incr pass} {
    for {set i 0} {$i < 10000000} {incr i} {
        incr total [lindex $arr $i]
    }
}

set __t1 [clock microseconds]
puts stderr [format "TIME_MS=%.3f" [expr {($__t1 - $__t0) / 1000.0}]]
puts $total
