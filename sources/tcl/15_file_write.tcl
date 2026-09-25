# task 15 file_write — expected output: 104857600
# build: none (interpreted)    run: tclsh 15_file_write.tcl
# A 1 MiB buffer of the byte cycle 0..255 repeated 4096 times, written 100 times.
# The buffer is built with binary format c* over a repeated 256-byte cycle, which is
# one call rather than 1048576 appends. Tcl has no fsync on a channel, so the
# deviation is flush + close, the same one the D, Julia, Nim, Dart, Pascal, COBOL and
# Dolphin rows note.

set cycle {}
for {set i 0} {$i < 256} {incr i} {
    lappend cycle $i
}
set chunk [binary format c* $cycle]
set buf [string repeat $chunk 4096]

set f [open "out.bin" wb]
set written 0
for {set t 0} {$t < 100} {incr t} {
    puts -nonewline $f $buf
    incr written 1048576
}
flush $f
close $f

puts $written
