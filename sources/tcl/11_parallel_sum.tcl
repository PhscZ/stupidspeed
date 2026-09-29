# task 11 parallel_sum — expected output: 7500000075000000
# build: none (interpreted)    run: tclsh 11_parallel_sum.tcl
# Tcl has no threads in the core, so this uses the language's own threading
# extension, the Thread package, which is the same exception Lua's Lanes gets.
# The extension creates threads that each contain a Tcl interpreter, so a worker is a
# script sent to a fresh thread.
#
# thread::send -async hands the script to the worker and returns at once, so all four
# workers are dispatched before any of them has finished and the four quarters really do
# run at the same time on four cores. Each worker sends its own partial back to the main
# thread with a plain (synchronous) thread::send when it is done, and the main thread
# waits for the counter to reach zero. A blocking thread::send in the dispatch loop would
# instead wait for worker t to finish before starting worker t+1, so nothing would overlap.
# The four ranges are fixed, so the total does not depend on the order they finish in.

package require Thread

set main [thread::id]

# Runs in the main thread, once per worker: add one partial and count it in.
proc report {value} {
    global total pending
    incr total $value
    incr pending -1
}

set total 0
set pending 4
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
        proc run_work {main id} {
            thread::send $main [list report [work $id]]
        }
        thread::wait
    }]
}

for {set t 0} {$t < 4} {incr t} {
    thread::send -async [lindex $threads $t] [list run_work $main $t]
}

# Each report writes `pending`, so vwait wakes on every arrival and the loop
# re-arms until all four have reported.
while {$pending > 0} {
    vwait pending
}

for {set t 0} {$t < 4} {incr t} {
    thread::release [lindex $threads $t]
}

puts $total
