# task 14 file_read — expected output: 484442112
# build: none (interpreted)    run: tclsh 14_file_read.tcl
# One pass over 100 MiB in 1 MiB chunks. The bytes are unpacked with binary scan
# cu*, which turns a chunk into a list of unsigned byte values in one call, rather
# than 1048576 separate string index operations per chunk.

set f [open "data.bin" rb]
set total 0

while {![eof $f]} {
    set data [read $f 1048576]
    if {[string length $data] == 0} {
        break
    }
    binary scan $data cu* bytes
    incr total [::tcl::mathop::+ {*}$bytes]
}

close $f

puts [expr {$total % 4294967296}]
