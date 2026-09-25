# task 08 average — expected output: 0.498046875
# build: none (interpreted)    run: tclsh 08_average.tcl
# Tcl has only doubles, which is all this task needs. Each reading is a multiple of
# 1/256, exact in binary, so the sum is exact and the digits do not depend on the
# order the numbers are added in.

set total 0.0

for {set i 0} {$i < 100000000} {incr i} {
    set reading [expr {($i % 256) / 256.0}]
    set total [expr {$total + $reading}]
}

puts [expr {$total / 100000000.0}]
