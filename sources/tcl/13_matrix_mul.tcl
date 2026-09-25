# task 13 matrix_mul — expected output: 599995000
# build: none (interpreted)    run: tclsh 13_matrix_mul.tcl
# Plain triple loop, no tricks: the innermost loop walks B down a column, which is
# the cache-hostile order the task asks for.

set n 500
set a {}
set b {}

for {set i 0} {$i < $n} {incr i} {
    set ra {}
    set rb {}
    for {set j 0} {$j < $n} {incr j} {
        lappend ra [expr {($i + $j) % 7}]
        lappend rb [expr {($i * $j) % 5}]
    }
    lappend a $ra
    lappend b $rb
}

set c {}
for {set i 0} {$i < $n} {incr i} {
    set ra [lindex $a $i]
    set rc {}
    for {set j 0} {$j < $n} {incr j} {
        set sum 0
        for {set k 0} {$k < $n} {incr k} {
            incr sum [expr {[lindex $ra $k] * [lindex [lindex $b $k] $j]}]
        }
        lappend rc $sum
    }
    lappend c $rc
}

set total 0
for {set i 0} {$i < $n} {incr i} {
    set rc [lindex $c $i]
    for {set j 0} {$j < $n} {incr j} {
        incr total [lindex $rc $j]
    }
}

puts $total
