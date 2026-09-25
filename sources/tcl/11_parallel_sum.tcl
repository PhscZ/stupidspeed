# task 11 parallel_sum — expected output: 7500000075000000
# build: none (interpreted)    run: tclsh 11_parallel_sum.tcl
# Tcl has no threads in the core, so this uses the language's own threading
# extension, the Thread package, which is the same exception Lua's Lanes gets.
# The extension creates threads that each contain a Tcl interpreter, so a worker is a
# script sent to a fresh thread; the result comes back over thread::send.
# The four ranges are fixed, so the total does not depend on the order they finish in.

package require Thread

set scripts {}
set threads {}

for {set t 0} {$t < 4} {incr t} {
    lappend threads [thread::create {
        proc work {id} {
            set start [expr {$id * 25000000}]
            set stop [expr {$start + 25000000 - 1}]
            set acc 0
            for {set i $start} {$i <= $stop} {incr i} {
                switch [expr {$i % 4}] {
                    0 { incr acc 1 }
                    1 { incr acc $i }
                    2 { incr acc [expr {2 * $i}] }
                    3 { incr acc [expr {3 * $i}] }
                }
            }
            return $acc
        }
        thread::wait
    }]
}

set total 0
for {set t 0} {$t < 4} {incr t} {
    set total [expr {$total + [thread::send [lindex $threads $t] [list work $t]]}]
}

for {set t 0} {$t < 4} {incr t} {
    thread::release [lindex $threads $t]
}

puts $total
