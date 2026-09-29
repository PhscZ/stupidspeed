# task 14 file_read — expected output: 2389704704
# build: none (interpreted)    run: tclsh 14_file_read.tcl
# One pass over 50 MiB in 1 MiB chunks. binary scan cu* unpacks a chunk into a list of
# unsigned byte values in one call, which avoids a string index operation per byte; the
# bytes are then added one at a time in a plain loop, the same per-byte accumulation every
# other row runs. (Summing the list with a single ::tcl::mathop::+ call would be a bulk
# aggregate, which is not the loop the task asks for.)

set f [open "data.bin" rb]
set total 0

while {![eof $f]} {
    set data [read $f 1048576]
    if {[string length $data] == 0} {
        break
    }
    binary scan $data cu* bytes
    foreach b $bytes {
        incr total $b
    }
}

close $f

puts [expr {$total % 4294967296}]
