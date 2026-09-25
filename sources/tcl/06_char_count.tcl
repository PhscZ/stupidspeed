# task 06 char_count — expected output: 10000000
# build: none (interpreted)    run: tclsh 06_char_count.tcl
# The 100 MB text is one string repeat of the whole 10000-byte block, not an append
# loop, so the build is not the benchmark. The scan walks the string one character at
# a time with string index.

set block [string repeat "abcdefghij" 1000]
set text [string repeat $block 10000]

set count 0
set len [string length $text]
for {set i 0} {$i < $len} {incr i} {
    set ch [string index $text $i]
    if {$ch eq "a"} {
        # skip
    } elseif {$ch eq "e"} {
        # skip
    } elseif {$ch eq "h"} {
        incr count
    }
}

puts $count
