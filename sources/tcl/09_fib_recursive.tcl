# task 09 fib_recursive — expected output: 102334155
# build: none (interpreted)    run: tclsh 09_fib_recursive.tcl
# Naive fib(40), about 331 million proc calls.

proc fib {n} {
    if {$n < 2} {
        return $n
    }
    return [expr {[fib [expr {$n - 1}]] + [fib [expr {$n - 2}]]}]
}

puts [fib 40]
