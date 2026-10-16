# task 15 file_write — expected output: 419430400
# build: none (interpreted)    run: tclsh 15_file_write.tcl
# A 1 MiB buffer of the byte cycle 0..255 repeated 4096 times, built once and written 50
# times per pass, 8 passes over out.bin (reopened at offset 0 each pass).
# The buffer is built with binary format c* over a repeated 256-byte cycle, which is
# one call rather than 1048576 appends. Tcl has no fsync on a channel, so the
# deviation is flush + close, one per pass, the same one the D, Julia, Nim, Dart, Pascal,
# COBOL and Dolphin rows note.

set __t0 [clock microseconds]
set cycle {}
for {set i 0} {$i < 256} {incr i} {
    lappend cycle $i
}
set chunk [binary format c* $cycle]
set buf [string repeat $chunk 4096]

set written 0
for {set p 0} {$p < 8} {incr p} {
    set f [open "out.bin" wb]
    for {set t 0} {$t < 50} {incr t} {
        puts -nonewline $f $buf
        incr written 1048576
    }
    flush $f
    close $f
}

set __t1 [clock microseconds]
puts stderr [format "TIME_MS=%.3f" [expr {($__t1 - $__t0) / 1000.0}]]
puts $written
