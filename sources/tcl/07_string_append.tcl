# task 07 string_append — expected output: 1000000
# build: none (interpreted)    run: tclsh 07_string_append.tcl
# Plain string concatenation. Tcl's string values are immutable, so every append
# copies the whole thing and the task is quadratic by design.

set text ""
for {set i 0} {$i < 1000000} {incr i} {
    append text "x"
}

puts [string length $text]
