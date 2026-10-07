# task 07 string_append — expected output: 250000
# build: none (interpreted)    run: tclsh 07_string_append.tcl
# Plain string concatenation, written with Tcl's own `append`, which is the idiomatic
# spelling of `text = text + "x"`. It is *not* the quadratic cell the task is designed to
# measure: `append` extends the variable's value in place when that value is unshared,
# which is why the command exists and why the manual recommends it over the `set` form, so
# the 250000 appends are amortised. Measured: 0.28 s, and linear in the append count —
# 321 / 567 / 1179 ms at 250000 / 500000 / 1000000. The copy form is the quadratic one and
# is 27x slower at the row's own loop count (`set text $text"x"`: 8890 ms at 250000), but
# substituting it would be a different program from the one every other row runs. The
# deviation is recorded in RUN.md, the same one the AutoHotkey, Dyalog, Lobster, Raku,
# Erlang and Elixir rows carry.

set __t0 [clock microseconds]
set text ""
for {set i 0} {$i < 250000} {incr i} {
    append text "x"
}

set __t1 [clock microseconds]
puts stderr [format "TIME_MS=%.3f" [expr {($__t1 - $__t0) / 1000.0}]]
puts [string length $text]
