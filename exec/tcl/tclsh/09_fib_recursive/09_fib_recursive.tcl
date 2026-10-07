# task 09 fib_recursive — expected output: 102334155
# build: none (interpreted)    run: tclsh 09_fib_recursive.tcl
# Naive fib(40), about 331 million proc calls.

set __t0 [clock microseconds]
proc fib {n} {
    if {$n < 2} {
        return $n
    }
    return [expr {[fib [expr {$n - 1}]] + [fib [expr {$n - 2}]]}]
}

set __result [fib 40]
set __t1 [clock microseconds]
puts stderr [format "TIME_MS=%.3f" [expr {($__t1 - $__t0) / 1000.0}]]
puts $__result
