# task 02 switch_case — expected output: 7500000075000000
# build: none (interpreted)    run: tclsh 02_switch_case.tcl
# Tcl's `switch` with a -exact pattern list, over the same i % 4 predicate.

set acc 0

for {set i 0} {$i < 100000000} {incr i} {
    switch [expr {$i % 4}] {
        0 { incr acc 1 }
        1 { incr acc $i }
        2 { incr acc [expr {2 * $i}] }
        3 { incr acc [expr {3 * $i}] }
    }
}

puts $acc
