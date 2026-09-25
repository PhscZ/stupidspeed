# task 10 pi — expected output: 44889
# build: none (interpreted)    run: tclsh 10_pi.tcl
# Tcl's integers are arbitrary precision since 8.5, backed by LibTomMath (TIP 237),
# so this is the real Gibbons unbounded spigot with no hand-rolled limbs. Only the
# digit sum is printed.
# The update order matters: the produce branch computes the next n from the q and r
# as they were on entry, before q and r move.

set q 1
set r 0
set t 1
set k 1
set n 3
set l 3
set total 0
set emitted 0

while {$emitted < 10000} {
    if {4 * $q + $r - $t < $n * $t} {
        incr total $n
        incr emitted
        set nextn [expr {(10 * (3 * $q + $r)) / $t - (10 * $n)}]
        set q [expr {10 * $q}]
        set r [expr {10 * ($r - ($n * $t))}]
        set n $nextn
    } else {
        set q2 [expr {$q * $k}]
        set r2 [expr {(2 * $q + $r) * $l}]
        set t2 [expr {$t * $l}]
        set n [expr {($q * (7 * $k + 2) + ($r * $l)) / $t2}]
        set q $q2
        set r $r2
        set t $t2
        incr k
        incr l 2
    }
}

puts $total
