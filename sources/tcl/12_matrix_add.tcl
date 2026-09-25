# task 12 matrix_add — expected output: 999000000
# build: none (interpreted)    run: tclsh 12_matrix_add.tcl
# Three 1000x1000 arrays, 24 MB together, too big to sit in cache. Rows are lists of
# lists, so a row is one contiguous Tcl list.

set n 1000
set a {}
set b {}

for {set i 0} {$i < $n} {incr i} {
    set ra {}
    set rb {}
    for {set j 0} {$j < $n} {incr j} {
        lappend ra [expr {$i + $j}]
        lappend rb [expr {$i - $j}]
    }
    lappend a $ra
    lappend b $rb
}

set c {}
for {set i 0} {$i < $n} {incr i} {
    set ra [lindex $a $i]
    set rb [lindex $b $i]
    set rc {}
    for {set j 0} {$j < $n} {incr j} {
        lappend rc [expr {[lindex $ra $j] + [lindex $rb $j]}]
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
