# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: none (interpreted)    run: tclsh 01_branches.tcl
# Tcl has one numeric type in the source; the values here stay in native long
# integers, so the counters are ordinary Tcl integers.

set __t0 [clock microseconds]
set a 0
set b 0
set c 0
set d 0

for {set i 0} {$i < 100000000} {incr i} {
    set r [expr {$i % 3}]
    if {$r == 0} {
        incr a
    } else {
        set r [expr {$i % 5}]
        if {$r == 0} {
            incr b
        } else {
            set r [expr {$i % 7}]
            if {$r == 0} {
                incr c
            } else {
                incr d
            }
        }
    }
}

set __t1 [clock microseconds]
puts stderr [format "TIME_MS=%.3f" [expr {($__t1 - $__t0) / 1000.0}]]
puts "$a $b $c $d"
