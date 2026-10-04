# task 05 alloc_churn — expected output: 1274991808
# build: none (interpreted)    run: tclsh 05_alloc_churn.tcl
# Ten million 64-byte buffers. Tcl has no raw allocation primitive, so a buffer is a
# 64-character string; the slot store drops the buffer it replaces and Tcl frees it,
# which is the "free the old one" branch of the C reference.

set __t0 [clock microseconds]
set slots [lrepeat 256 ""]
set total 0

for {set i 0} {$i < 10000000} {incr i} {
    set buf [string repeat "\x00" 64]
    set b [expr {$i % 256}]
    set buf [string replace $buf 0 0 [format %c $b]]
    incr total [scan [string index $buf 0] %c]
    lset slots [expr {$i % 256}] $buf
}

set __t1 [clock microseconds]
puts stderr [format "TIME_MS=%.3f" [expr {($__t1 - $__t0) / 1000.0}]]
puts $total
